# AutoUploadLongMessages

[![Release](https://img.shields.io/github/v/release/eric99543/vencord-auto-upload-long-messages)](https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/eric99543/vencord-auto-upload-long-messages/total)](https://github.com/eric99543/vencord-auto-upload-long-messages/releases)
[![License](https://img.shields.io/github/license/eric99543/vencord-auto-upload-long-messages)](LICENSE)

A small Vencord userplugin that automatically chooses Discord's native `message.txt` upload flow when a message exceeds Discord's length limit.

It does not send messages through the Discord API. It activates the same upload option Discord already presents to the user.

> [!IMPORTANT]
> This is an unofficial userplugin for source-built Vencord. It is not supported by the Vencord project, and Discord updates may break its patch.

## Features

- Automatically selects Discord's native text-file upload option.
- Uses the current channel and Discord's existing upload UI.
- Makes no external network requests.
- Has no settings or background services.
- Prevents duplicate activation while an upload is being prepared.

## Screenshot

![AutoUploadLongMessages workflow preview](docs/images/oversized-message-flow.png)

The plugin acts on Discord's oversized-message dialog and has no persistent interface of its own. The image above is a privacy-safe product preview; Discord wording may vary by client version.

## Install

### Download the plugin ZIP

1. Download [`autoUploadLongMessages.zip`](https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest/download/autoUploadLongMessages.zip).
2. Extract it into `<Vencord>/src/userplugins/`.
3. From the Vencord directory, run:

   ```shell
   pnpm build --disable-updater
   pnpm inject --branch stable
   ```

4. Restart Discord and enable **AutoUploadLongMessages** under **Settings > Vencord > Plugins**.

The extracted layout must be:

```text
Vencord/
└── src/
    └── userplugins/
        └── autoUploadLongMessages/
            └── index.ts
```

### Windows one-click installer

Download and double-click [`Install.bat`](https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest/download/Install.bat). It downloads the current PowerShell installer, installs the newest plugin release, rebuilds Vencord, reinjects Discord Stable, and starts Discord again.

If Windows warns about the downloaded file, review the source in [`scripts/Install.bat`](scripts/Install.bat) and choose **Run anyway** only if you trust it.

Alternatively, download [`Install.ps1`](https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest/download/Install.ps1) and run it from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install.ps1
```

Both installers download the latest plugin ZIP, copy it into `Documents\Vencord`, rebuild Vencord with the official updater disabled, reinject Discord Stable, and start Discord again.

For a custom Vencord location:

```powershell
.\Install.ps1 -VencordPath "D:\Code\Vencord"
```

## Usage

Enable the plugin and send an oversized message normally. When Discord prepares its native `message.txt` choice, the plugin selects that flow automatically.

## Updating

Download the latest Release and repeat the installation. The Windows installer always downloads the newest published version.

## Compatibility

This plugin patches Discord internals. A successful Vencord build does not guarantee that the current Discord client still matches the patch. Please include Discord and Vencord versions in bug reports.

## License

[GPL-3.0-or-later](LICENSE), matching Vencord's licensing model.

## 繁體中文

當訊息超過 Discord 字數限制時，這個插件會自動選擇 Discord 原生的 `message.txt` 上傳方式。它不會直接呼叫 Discord API，也不會連線到外部服務。

下載 Release 中的 ZIP，解壓到 `Vencord/src/userplugins` 後重新建置；Windows 使用者也可以下載 `Install.ps1` 自動完成安裝。
