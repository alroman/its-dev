# IAM Devevloper

# Git Basics

Make sure to configure git with basic defaults.

## Git sanity check

This will make sure that when you do a 'git push', only your _current_ branch will be sent upstream.

```sh
git config --global push.default simple
```

# App Deployments

In general we want to follow a pattern in our project structure that relies on symlinks to hide
private of configuration details.  We also want to use symlinks to put cache/log directories
away from the app.  The benefit in this is that we can separate our versioned code from temporary 
files and structures required by our code.  

These are directories that are being written to in a web context, and thus require ACL and SELinux permissions to maintain security.  ACL and SELinux can be tricky, so keeping them separate ensures that we only need to do this once and just symlink to these dirs from our codebase.

## Symfony deployment

Symfony uses a `cache` and `logs` directory as well as a `config` file.  We will keep these
separate from our project.

```sh
ln -s /usr/local/web/api/shared/cache app/cache
ln -s /usr/local/web/api/shared/logs app/logs
```

### Enabling ACL

To check if ACL is enabled run `$ mount`

```sh
mount
/dev/mapper/VolGroup-lv_root on / type ext4 (rw,acl)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw,rootcontext="system_u:object_r:tmpfs_t:s0")
/dev/sda1 on /boot type ext4 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
/dev/sr0 on /mnt/cdrom type iso9660 (ro)
```

If you don't see `acl`, then it needs to be enabled in `/etc/fstab`.  Edit that file and add it

```sh
#
# /etc/fstab
# Created by anaconda on Fri Jan 25 12:11:16 2013
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/VolGroup-lv_root /                       ext4    defaults,acl        1 1
```

Re mount the partition.  This will not require a system restart..

```
$ sudo mount / -o remount
```

You should see `acl` if you run mount again.

### Using ACL with apache user

Let's give the `apache` and `symfony` users read, write, execute access on the `logs` and `cache` directories.

```
$ sudo setfacl -R -n -m u:apache:rwX -m u:symfony:rwX /usr/local/web/api/shared/cache /usr/local/web/api/shared/logs
$ sudo setfacl -dR -n -m u:apache:rwX -m u:symfony:rwX /usr/local/web/api/shared/cache /usr/local/web/api/shared/logs
```

### Enabling SELinux

SELinux will still prevent the `apache` user from writing to those directories, so
we need to let set some flags.

```
sudo chcon -t httpd_sys_content_t /usr/local/web/api/shared/cache
sudo chcon -t httpd_sys_content_t /usr/local/web/api/shared/logs
```