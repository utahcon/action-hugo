# action-hugo

The world’s fastest framework for building websites now has a Github Action that's just as fast! Why wait for Hugo to 
**build** each time you deploy your site? 

`utahcon/action-hugo` uses **pre-built** Docker containers to run your Hugo builds.
 
You can even leverage them without Github Actions: [see here](https://hub.docker.com/r/utahcon/hugo)

## Usage
Simple to use, just add a step to your workflow as follows:

```yaml
- name: Hugo Build
  uses: utahcon/actions-hugo@v0.73.0
```

Want to stay on the bleeding edge? You can use the tag `latest` to always pull the latest build of Hugo. We build every 
time a new version of Hugo is released!
 
You can substitute any version of Hugo back to `v0.59.0`!!

## Flexible
Each version allows you to pass in the appropriate command line arguments through `inputs`; these are the inputs allowed
for `v0.73.0`

| Name | Type | Description |
|------|------|-------------|
| baseURL | string | hostname (and path) to the root, e.g. http://spf13.com/ |
| buildDrafts |  | include content marked as draft |
| buildExpired |  | include expired content |
| buildFuture |  | include content with publishdate in the future |
| cacheDir | string | filesystem path to cache directory. Defaults: $TMPDIR/hugo_cache/ |
| cleanDestinationDir |  | remove files from destination not found in static directories |
| config | string | config file (default is path/config.yaml|json|toml) |
| configDir | string | config dir (default "config") |
| contentDir | string | filesystem path to content directory |
| debug |  | debug output |
| destination | string | filesystem path to write files to |
| disableKinds | strings | disable different kind of pages (home, RSS etc.) |
| enableGitInfo |  | add Git revision, date and author info to the pages |
| environment | string | build environment |
| forceSyncStatic |  | copy all files when static is changed. |
| gc |  | enable to run some cleanup tasks (remove unused cache files) after the build |
| help |  | help for hugo |
| i18n-warnings |  | print missing translations |
| ignoreCache |  | ignores the cache directory |
| ignoreVendor |  | ignores any _vendor directory |
| layoutDir | string | filesystem path to layout directory |
| log |  | enable Logging |
| logFile | string | log File path (if set, logging enabled automatically) |
| minify |  | minify any supported output format (HTML, XML etc.) |
| noChmod |  | don't sync permission mode of files |
| noTimes |  | don't sync modification time of files |
| path-warnings |  | print warnings on duplicate target paths etc. |
| quiet |  | build in quiet mode |
| renderToMemory |  | render to memory (only useful for benchmark testing) |
| source | string | filesystem path to read files relative from |
| templateMetrics |  | display metrics about template executions |
| templateMetricsHints |  | calculate some improvement hints when combined with --templateMetrics |
| theme | strings | themes to use (located in /themes/THEMENAME/) |
| themesDir | string | filesystem path to themes directory |
| trace | file | write trace to file (not useful in general) |
| verbose |  | verbose output |
| verboseLog |  | verbose logging |
| watch |  | watch filesystem for changes and recreate as needed |
