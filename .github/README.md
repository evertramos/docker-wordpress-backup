# Docker Wordpress Backup

This script is meant to automatically backup your wordpress site and database.

It will work out of the box if you use our environment:

- proxy:
https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion

- wordpress:
https://github.com/evertramos/docker-wordpress-letsencrypt

If you don't... you might want to check it out! But still this script can be configured to your environment as well.

In the last version of out Docker Wordpress LetsEncrypt repo we have updated the '.env' file to comply with the settings required by this script.

## Why you should use it

Well, backup is always important, and if you can have it done by a script even better!

## BEFORE YOU START

Before setting up this repo into your project, please be aware of how your folder sctructure should look like:

Let's say you have your site files under your home directory called 'sites', so should look like something like that:

![Docker Wordpress Folder Structure](https://github.com/evertramos/images/blob/master/docker-wordpress-site-structure.png)

So, we have the base folder **sites** where holds all sites we are running on the server... and in that case **mysite.com** is where we will locate all of our files... which will be:

```
mysite.com/
|--- backup - The backup files for our wordpress
|--- bin - All scripts for our site
|--- compose - The compose file for our site, such as [Docker Wordpress LetsEncrypt](https://github.com/evertramos/docker-wordpress-letsencrypt)
|--- data - Data from my site (Database and Wordpress files)
```


## How to

1. Clone the repo into your **bin** folder....

2. Set up your **.env** file on **compose** folder with these options:

```bash
BACKUP_PATH_NAME=./../backup
BACKUP_CRONTAB_RULE="00 04 * * 1-5"
```

If you use our [Docker Wordpress LetsEncrypt](https://github.com/evertramos/docker-wordpress-letsencrypt), make sure you update your .env file with these lines, as of:

[.env.sample](https://github.com/evertramos/docker-wordpress-letsencrypt/blob/003ee68ad67ab78441b669d859a46dce6ada3d6b/.env.sample#L54)

> In our example above we will use the **backup** folder to keep the backup, but we recommend using another disk attached to your server which would be mounted in another location. Just set up here where is mounted, example: */backup*

> There should NOT be an **.env** file inside the bin folder... It must remain in **/compose** folder, the script will automatically create a symlink as of `ln -s ./../compose/.env .`

3. Create the folder structured for the backup as defined in your compose file under the variable `$BACKUP_PATH_NAME` including folder **db** and **site**

```bash
$ pwd
/home/user/sites/mysite.com

$ mkdir backup

$ cd backup

$ mkdir db

$ mkdir site
```

4. Run the backup script!

```bash
$ pwd
/home/user/sites/mysite.com/bin

$ ./run-backup.sh
```

That's all!

### Futher options

#### If you want to set a cron job to run the backup please check the (crontab.guru)[https://crontab.guru/] and set your option in the `BACKUP_CRONTAB_RULE=...` variable then just run the `set-crontab.sh` script:

```bash
$ pwd
/home/user/sites/mysite.com/bin

$ ./set-crontab.sh
```
