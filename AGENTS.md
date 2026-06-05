# AGENTS.md

## Repository Overview

- Branches labeled `lab-${VERSION}` connect the OpenShift version of the lab with specific
Hosted Control Planes instructions.
- The live site is published at
https://labs.sysdeseng.com/hypershift-baremetal-lab/${VERSION}/index.html
e.g. [For branch lab-4.18](https://labs.sysdeseng.com/hypershift-baremetal-lab/4.18/index.html)

## Document Testing

- Run all linters `npm run lint`
- Or use pre-commit hooks (recommended) `pre-commit run --all-files`
- Build site with `npx gulp clean build`
- Check for content in `./gh-pages`
