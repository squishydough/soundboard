# CHANGELOG

## How to update the script

There is no great way to update the script without some possible duplication of previous efforts.  I try to keep this to a minimum, but you should still consider and do the following before upgrading to a newer version.

- Make a backup of your `sounds` folder in case you accidentally overwrite it.
- Make a backup of your `user-settings.ahk` file.  Changes sometimes affect this file, but you also have customizations specific to you.  You may have to reenter your custom data when using an updated `user-settings.ahk` file.

Once you have everything backed up, download the latest .zip file and drag the files like you did when you first installed the script.  [See the README.md file for more specific setup instructions](./README.md)

## Changes for 08/21/21
- Added Powershell script to README.md in order to claim ownership of sound libraries (rarely needed).

## Changes for 04/18/21

- Fixed a bug causing errors to be thrown if incorrect or empty `keyboard_vid` or `keyboard_pid` was found.
- Added **RANDOM SOUND** button to play a random sound from the entire sound library.

## Changes for 03/25/21

- Fixed errors that popped up when toggling and untoggling second keyboard in some situations.
- Fixed bug where categories listview would not filter properly after pressing a key on the second keyboard.

## Changes for 03/23/21

- Added default setting for **Include Category When Filtering Specific Sounds?** to `user-settings.ahk`.
- Moved **Include Category When Filtering Specific Sounds?** checkbox to Specific Sounds list view.
- Moved **Intercept Second Keyboard?** checkbox to top of window.
- Reduced total window height.
