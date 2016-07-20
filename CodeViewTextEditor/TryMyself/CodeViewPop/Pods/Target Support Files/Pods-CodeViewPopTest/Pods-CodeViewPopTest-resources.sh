#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "$RESOURCE_PATH")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "WEPopover/Resources/Popover/popoverArrowDown-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDown.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDown@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDownSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeftSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRightSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUpSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverBg-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverBg.png"
  install_resource "WEPopover/Resources/Popover/popoverBg@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverBgSimple.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/backcolor.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bold.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bold@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bullist.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bullist@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/button.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttoncenter.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttoncenterSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonleft.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonleftSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonright.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonrightSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/dropDownTriangle.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/dropDownTriangle@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/code.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/colors.jpg"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/colorsOld.jpg"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/email.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/file.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/firstLineIndent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/firstLineIndent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/forecolor.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/image.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/indent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/indent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/italic.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/italic@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifycenter.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifycenter@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyfull.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyfull@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyleft.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyleft@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyright.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyright@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/link.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/numlist.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/numlist@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/outdent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/outdent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/redo.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/removeformat.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/strikethrough.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/strikethrough@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/underline.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/underline@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/undo.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/unlink.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "WEPopover/Resources/Popover/popoverArrowDown-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDown.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDown@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowDownSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeft@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowLeftSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRight@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowRightSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUp@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverArrowUpSimple.png"
  install_resource "WEPopover/Resources/Popover/popoverBg-white@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverBg.png"
  install_resource "WEPopover/Resources/Popover/popoverBg@2x.png"
  install_resource "WEPopover/Resources/Popover/popoverBgSimple.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/backcolor.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bold.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bold@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bullist.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/bullist@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/button.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttoncenter.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttoncenterSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonleft.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonleftSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonright.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonrightSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/buttonSelected.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/dropDownTriangle.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons/dropDownTriangle@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/code.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/colors.jpg"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/colorsOld.jpg"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/email.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/file.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/firstLineIndent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/firstLineIndent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/forecolor.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/image.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/indent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/indent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/italic.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/italic@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifycenter.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifycenter@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyfull.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyfull@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyleft.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyleft@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyright.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/justifyright@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/link.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/numlist.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/numlist@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/outdent.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/outdent@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/redo.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/removeformat.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/strikethrough.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/strikethrough@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/underline.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/underline@2x.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/undo.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/unlink.png"
  install_resource "iOS-Rich-Text-Editor/RichTextEditor/Source/Assets/buttons"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
