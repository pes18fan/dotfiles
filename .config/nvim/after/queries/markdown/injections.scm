; Highlight certain JS-like features in mdx
; extends
((inline) @injection.content
    (#lua-match? @injection.content "^%s*import")
    (#set! injection.language "typescript"))
((inline) @injection.content
    (#lua-match? @injection.content "^%s*export")
    (#set! injection.language "typescript"))
