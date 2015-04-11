IAM-Dev

# GIT

Make sure to configure git with basic defaults.

## Git sanity check

This will make sure that when you do a 'git push', only your _current_ branch will be sent upstream.

```sh
git config --global push.default simple
```