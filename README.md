# action-hugo

The world’s fastest framework for building websites now has a Github Action that's just as fast! Why wait for Hugo to 
**build** each time you deploy your site? 

`utahcon/action-hugo` uses **pre-built** Docker containers to run your Hugo builds.
 
You can even leverage them without Github Actions: [see here](https://hub.docker.com/r/utahcon/hugo)

## Usage
Simple to use, just add a step to your workflow as follows:

```yaml
- name: Hugo Build
  uses: utahcon/actions-hugo@%%VERSION%%
```

Want to stay on the bleeding edge? You can use the tag `latest` to always pull the latest build of Hugo. We build every 
time a new version of Hugo is released!
 
You can substitute any version of Hugo back to `v0.59.0`!!

## Flexible
Each version allows you to pass in the appropriate command line arguments through `inputs`; these are the inputs allowed
for `%%VERSION%%`

| Name | Type | Description |
|------|------|-------------|%%README_INPUTS%%
