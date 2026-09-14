/*
 * Vencord, a Discord client mod
 * Copyright (c) 2026 Vendicated and contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import definePlugin from "@utils/types";

let uploadPending = false;

export default definePlugin({
    name: "AutoUploadLongMessages",
    description: "Automatically uses Discord's native text-file upload flow for oversized messages",
    authors: [{ name: "eric99543", id: 0n }],

    patches: [
        {
            find: /onSecondaryClick:function\(\)\{.{0,300}"message\.txt","text\/plain"/,
            group: true,
            replacement: [
                {
                    match: /return(\(0,\i\.jsx\)\(\i\.A,\{title:.{0,1000}?,\.\.\.\i\}\))/,
                    replace: "return $self.autoUpload($1)"
                },
                {
                    match: /requireConfirm:!0/,
                    replace: "requireConfirm:!1"
                }
            ]
        }
    ],

    autoUpload(element: { props: { onSecondaryClick: () => void; }; }) {
        if (uploadPending) return null;
        uploadPending = true;

        queueMicrotask(() => {
            element.props.onSecondaryClick();
            setTimeout(() => uploadPending = false, 1000);
        });

        return null;
    }
});
