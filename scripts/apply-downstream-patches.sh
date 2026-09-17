#!/usr/bin/env bash
# 下游补丁的唯一套用入口：CI 构建与 release 预检都调用这里。
# 版本到补丁集合的映射只在本文件维护，避免版本条件散落在各 workflow 里各自漂移。
#
# 用法: scripts/apply-downstream-patches.sh <version> <source-root>
#   <version>      目标版本（如 v3.8.4），决定 siyuan / siyuan-ios 侧的补丁集合
#   <source-root>  目录内可含 siyuan/、siyuan-android/、siyuan-ios/（存在即套用，缺失则跳过）
#
# 未登记的版本直接失败：补丁是按版本维护的，宁可在发版前失败，也不要发出打不上补丁的版本。
set -euo pipefail

# 说明：patches/siyuan/ 下的 hide-account-entry.patch 与 first-launch-notice.patch 是 3.8.4 之前的
# 通用版本，未列入下表任何版本的补丁集合（各版本链路在本文件的 case 里显式列出）。
# 保留它们只是为了对照历史，不会被构建或预检套用。

version="${1:?usage: scripts/apply-downstream-patches.sh <version> <source-root>}"
source_root="${2:?usage: scripts/apply-downstream-patches.sh <version> <source-root>}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
patches_dir="$(cd "${script_dir}/../patches" && pwd)"

case "${version}" in
v3.8.3)
	siyuan_patches=(
		disable-update.patch
		default-config.patch
		mock-vip-user.patch
		account-v3.8.3.patch
	)
	ios_patches=()
	;;
v3.8.4)
	siyuan_patches=(
		disable-update.patch
		default-config-v3.8.4.patch
		mock-vip-user-v3.8.4.patch
		hide-account-entry-v3.8.4.patch
		first-launch-notice-v3.8.4.patch
	)
	# siyuan-ios 侧无需补丁：xcode 26 的 loadItem 修复已在上游 main 落地。
	ios_patches=()
	;;
*)
	echo "::error::no downstream patch set for ${version}; add one to scripts/apply-downstream-patches.sh" >&2
	exit 1
	;;
esac

android_patches=(
	debug-build.patch
	dual-package.patch
)

apply_patches() {
	local target="$1"
	local label="$2"
	shift 2

	echo "== ${label}: applying ${#} patch(es) in ${target}"
	local name
	for name in "$@"; do
		if [ "${label}" = "siyuan-android" ]; then
			# 上游 Android 侧的上下文空白不稳定，沿用构建流程一直以来的宽松匹配。
			echo "   git apply --ignore-whitespace ${name}"
			git -C "${target}" apply --ignore-whitespace "${patches_dir}/${label}/${name}"
		else
			echo "   git apply ${name}"
			git -C "${target}" apply "${patches_dir}/${label}/${name}"
		fi
	done
}

if [ -d "${source_root}/siyuan" ]; then
	apply_patches "${source_root}/siyuan" siyuan "${siyuan_patches[@]}"
else
	echo "::error::missing ${source_root}/siyuan" >&2
	exit 1
fi

if [ -d "${source_root}/siyuan-android" ]; then
	apply_patches "${source_root}/siyuan-android" siyuan-android "${android_patches[@]}"
else
	echo "== siyuan-android: not present, skipped"
fi

if [ -d "${source_root}/siyuan-ios" ]; then
	if [ "${#ios_patches[@]}" -eq 0 ]; then
		echo "== siyuan-ios: no downstream patch for ${version}, skipped"
	else
		apply_patches "${source_root}/siyuan-ios" siyuan-ios "${ios_patches[@]}"
	fi
else
	echo "== siyuan-ios: not present, skipped"
fi
