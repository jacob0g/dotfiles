---
name: auditing-performance
description: Audit and optimize application performance — broad checklist (bundle size, rendering, data fetching, DB queries, assets, Core Web Vitals) plus deep CPU profiling with Cursor's built-in browser profiler. Use when a page is slow, janky, or needs a performance review.
---

# Performance Audit & Profiling

Use this skill when the user asks to optimize performance, reduce load times, fix slow or janky pages, audit Core Web Vitals, or profile CPU usage.

## Quick Audit

A broad checklist for identifying the most common performance problems.

### 1. Bundle size

- Run `npx @next/bundle-analyzer` (Next.js) or `npx vite-bundle-visualizer` (Vite) to identify large dependencies.
- Look for large libraries that could be replaced with lighter alternatives (e.g. `moment` → `date-fns`, `lodash` → individual imports or native methods).
- Check for duplicated dependencies in the bundle.
- Verify tree-shaking is working (no barrel file re-exports pulling in unused code).

### 2. Rendering

- Identify components that re-render unnecessarily — look for inline object/array/function creation in JSX props.
- Check for expensive computations in render paths that should use `useMemo`.
- Verify lists use proper `key` props (not array index for dynamic lists).
- Look for layout thrashing (reading DOM measurements then writing styles in a loop).

### 3. Data fetching

- Identify request waterfalls — sequential API calls that could be parallelized with `Promise.all`.
- Look for data fetched on the client that could be fetched on the server.
- Check for missing pagination on large data sets.
- Verify API responses aren't over-fetching (returning fields the client doesn't need).

### 4. Database queries

- Look for N+1 query patterns (a query per item in a list).
- Check for missing indexes on columns used in WHERE, ORDER BY, and JOIN clauses.
- Identify queries that could use `SELECT` with specific columns instead of `SELECT *`.
- Look for missing connection pooling.

### 5. Assets

- Verify images use modern formats (WebP/AVIF) and are properly sized.
- Check for missing `loading="lazy"` on below-the-fold images.
- Verify fonts use `font-display: swap` and are preloaded.
- Check for render-blocking CSS or JavaScript.

### 6. Recommendations

Produce a prioritized list of optimizations ranked by impact (High / Medium / Low) with estimated effort for each.

## Deep Profiling

When the broad audit points to a specific slow page or interaction, use Cursor's built-in browser profiler to capture real CPU call stacks and timing data.

### How it works

The `cursor-ide-browser` MCP provides `browser_profile_start` and `browser_profile_stop` tools that capture Chrome DevTools-format CPU profiles. Profile data is written to `~/.cursor/browser-logs/` as both raw JSON and a human-readable summary.

### Steps

1. **Ensure the app is running** — start the dev server if it isn't already running.

2. **Navigate to the slow page**:

   ```
   Tool: browser_navigate
   Arguments: { "url": "http://localhost:3000/slow-page" }
   ```

3. **Start profiling**:

   ```
   Tool: browser_profile_start
   ```

4. **Reproduce the slow interaction** — use browser tools to trigger the slow behavior:
   - Click buttons, scroll, type in inputs, navigate between pages
   - Use `browser_click`, `browser_scroll`, `browser_fill` to interact
   - Wait a few seconds for the interaction to complete

5. **Stop profiling**:

   ```
   Tool: browser_profile_stop
   ```

   This writes two files to `~/.cursor/browser-logs/`:
   - `cpu-profile-{timestamp}.json` — raw Chrome DevTools profile
   - `cpu-profile-{timestamp}-summary.md` — human-readable summary

6. **Analyze the results** — read both files. Key things to look for in the raw JSON:
   - `profile.nodes[].hitCount` — how many samples hit each function
   - `profile.nodes[].callFrame.functionName` — the function names
   - `profile.samples.length` — total number of samples collected

   Cross-reference with the summary to identify:
   - Functions consuming the most CPU time
   - Unexpected re-renders or layout thrashing
   - Expensive third-party library calls
   - Synchronous operations blocking the main thread

7. **Suggest fixes** — based on the profile data, recommend specific optimizations:
   - Memoize expensive computations
   - Debounce rapid event handlers
   - Move heavy work to a Web Worker
   - Lazy-load components or routes
   - Virtualize long lists

## Notes

- Focus on measurable improvements — use Lighthouse, WebPageTest, or the Performance tab in DevTools.
- Don't prematurely optimize — profile first, optimize bottlenecks.
- For React apps, use React DevTools Profiler to identify slow components.
- Always read the raw `.json` profile to verify the summary — the summary can miss nuances.
- Profile in development mode first, but be aware that React dev mode adds overhead. For accurate measurements, profile a production build.
- Short profiles (2-5 seconds of interaction) are usually more useful than long ones.
- Compare before/after profiles to verify your optimization actually helped.
