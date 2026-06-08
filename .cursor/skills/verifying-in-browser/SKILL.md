---
name: verifying-in-browser
description: After making code changes, start the dev server, open the app in Cursor's built-in browser, and verify everything works — check rendering, console errors, and network health. Use proactively after any UI or API change.
---

# Verify in Browser

Use this skill proactively after making code changes to verify the app actually works. Don't just trust that the code is correct — launch it and check. This uses Cursor's built-in browser (`cursor-ide-browser` MCP) to navigate, screenshot, inspect console/network, and interact with page elements.

## Steps

1. **Start the dev server in the background** — check if one is already running by listing terminals. If not:

   ```bash
   npm run dev
   ```

   Set `block_until_ms: 0` to run it in the background. Then poll until you see the "ready" message with the localhost URL.

2. **Open in the side browser** — launch the app beside your code:

   ```
   Tool: browser_navigate
   Arguments: { "url": "http://localhost:3000", "position": "side", "take_screenshot_afterwards": true }
   ```

   If the change is on a specific route, navigate directly to it (e.g., `/settings`, `/dashboard`).

3. **Take a full-page screenshot** — capture the complete rendered state:

   ```
   Tool: browser_take_screenshot
   Arguments: { "fullPage": true }
   ```

   Review for visual issues: layout breaks, missing content, wrong colors, misaligned elements, blank screens, or loading spinners that never resolve.

4. **Check console for errors:**

   ```
   Tool: browser_console_messages
   ```

   Flag any errors — especially `TypeError`, `ReferenceError`, failed imports, or React hydration mismatches. Deprecation warnings can be noted but aren't blockers.

5. **Audit network requests:**

   ```
   Tool: browser_network_requests
   ```

   Flag any 4xx/5xx responses, failed fetches, CORS errors, excessively large responses, or unnecessary duplicate requests.

6. **Test interactions** — if you changed a form, button, or interactive element:
   - Take a `browser_snapshot` to get element refs
   - Click, fill, or hover on the changed elements
   - Take another screenshot to verify the result

7. **Check responsive viewports** — if the change affects layout, resize and re-check:

   ```
   Tool: browser_resize
   ```

   Test at mobile, tablet, and desktop widths to catch breakpoint issues.

8. **Report the verdict** — tell the user:
   - "Verified in browser — page renders correctly, no console errors, all network requests healthy."
   - Or: "Found issues: [list of problems]"

## When to Use This

- After changing any React component, CSS, or layout code
- After modifying API routes or data fetching
- After updating environment variables or configuration
- After installing or removing dependencies
- Before committing — as a final sanity check

## Notes

- Use `position: "side"` to see code and browser at the same time.
- If the dev server is already running, skip step 1 and go straight to navigating.
- For SSR apps, check both the initial server-rendered HTML and the client-hydrated state.
- Always use `browser_snapshot` before clicking elements to get the correct element refs.
