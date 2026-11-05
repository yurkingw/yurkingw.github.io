# Veiled Empyrean

Public root of <https://yurkingw.github.io/>.

This is an editorial foyer: a name, one line, and two entries. **Good Reads** links to the existing archive at `/x-good-reads/`. **Briefings** reserves `/briefings/` and is marked coming soon. It does not publish briefing posts.

## GitHub Pages

This repository is the GitHub **user site**. The live site is the repository root, published by **GitHub Actions**. Do not use a branch as the Pages source.

1. Open **Settings → Pages**.
2. Under **Build and deployment**, set **Source** to **GitHub Actions**.
3. Workflow [`.github/workflows/pages.yml`](.github/workflows/pages.yml) publishes the site when commits land on `main`.

The repository is still on the legacy branch source (`main` / `/`). Change that source to **GitHub Actions** before merging. Leaving it on a branch would publish the repository root by branch deploy, which this site does not use.

What the workflow does:

- Pull requests run `scripts/check-home.sh` and assemble `_site`. They do not deploy.
- A push to `main` uploads `_site` and deploys it with `actions/deploy-pages`.

`index.html`, `css/home.css`, `favicon.svg`, and `fonts/` are copied into the artifact. This README and `.github/` are not published.

The public URL is <https://yurkingw.github.io/>. It stays on the previous deployment until a `main` deploy succeeds. Merging is a separate, explicit step.

## Theme

The header control stores `day`, `night`, or `system` in `localStorage` under the key `ygh-theme`. `system` follows the visitor’s `prefers-color-scheme`. A small script in the document head applies a saved day or night choice before the stylesheet paints.

## Font

[Inter](https://github.com/rsms/inter) is included as a variable font under the SIL Open Font License. See [`fonts/OFL.txt`](fonts/OFL.txt).
