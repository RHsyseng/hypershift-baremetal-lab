# Hypershift Baremetal Lab

## Repository Overview

This repository contains an **Antora-based documentation site** for a hands-on
lab teaching Hosted Control Planes (HCP) on Baremetal for OpenShift.
Branches of this repository, labeled `lab-${VERSION}` connect the OpenShift
version that forms the basis of the lab with specific documentation relating to
HCP running on that version.
Hosted Control Planes clusters running on that version.
The live site is published at
https://labs.sysdeseng.com/hypershift-baremetal-lab/${VERSION}/index.html

This is the source code for [https://labs.sysdeseng.com/hypershift-baremetal-lab/4.18/index.html](https://labs.sysdeseng.com/hypershift-baremetal-lab/4.18/index.html)

**Technology Stack:**

- **Antora**: Static site generator for technical documentation
- **AsciiDoc**: Markup language for documentation content
- **Node.js/npm**: Build tooling and dependencies
- **Gulp**: Task automation for development workflow
- **Browser-sync**: Live reload during development

## Build and Development Commands

### Install Dependencies

```bash
npm install
```

### Development Server (with live reload)

```bash
npm run dev
# or
gulp
# Starts local server at http://localhost:3000
# Watches for changes to *.adoc, *.yml, *.hbs files
# Auto-rebuilds and reloads browser
```

### Production Build

```bash
./site.sh
# or
antora --stacktrace site.yml
# Outputs to ./gh-pages/
```

### Clean Build Artifacts

```bash
npm run clean
# or
gulp clean
# Removes gh-pages/ and .cache/ directories
```

## Content Authoring

### Adding New Pages

1. Create `.adoc` file in `documentation/modules/ROOT/pages/`
2. Add navigation entry to `documentation/modules/ROOT/nav.adoc` using `xref:` syntax:

   ```asciidoc
   * xref:new-page.adoc[New Page Title]
   ```

3. Use attributes from `_attributes.adoc` for version-specific content

### AsciiDoc Extensions Available

- **Tab blocks** (`lib/tab-block.js`): Custom syntax for tabbed content panels
- **Remote includes** (`lib/remote-include-processor.js`): Include content from remote URLs

### Site Configuration

- **Production**: Edit `site.yml` (branch: `lab-4.18`, outputs to gh-pages)
- **Development**: Edit `dev-site.yml` (localhost:3000, different branch reference)
- **Version attribute**: `release-version: 4.18` in playbook's `asciidoc.attributes`

## Key Antora Concepts for This Site

- **Component**: Single Antora component named "4.18" (version identifier)
- **Module**: Single ROOT module containing all pages
- **Content source**: Local repository, branch `lab-4.18`, start path `documentation/`
- **UI bundle**: Pre-built telco-themed bundle (`ui-bundle-telco.zip`)
- **Supplemental UI**: Overrides and additional UI files in `supplemental-ui/`

## Testing Changes

Since this is a documentation site, testing means:

1. Run `npm run dev` to start development server
2. Navigate to [http://localhost:3000/](http://localhost:3000/) in browser
3. Verify content renders correctly, links work, formatting is correct
4. Check browser console for any Antora warnings/errors
5. Test cross-references between pages
6. Verify code blocks, tables, images display properly

## Common Patterns

**Cross-referencing pages:**

```asciidoc
xref:target-page.adoc[Link Text]
xref:target-page.adoc#anchor[Link to Section]
```

**Using document attributes:**

```asciidoc
{release-version}  // Expands to 4.18
```
