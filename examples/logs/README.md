# BSFPE Examples

## Daily logs rotation

### Description
This script uses a 5-day or 7-day week to rotate logs.  
Logs are kept in directories named after the day of the week (Mon, Tue, Wed, ...).
For convenience, two symbolic links are added and point to the current and previous day. 

### Motivation
Although commands like `logrotate` can perform logs rotation efficiently, it is sometime too
powerful for simple usage. Application that logs rarely and only non meaningfull / non important information.
But you still want to keep the daily notion to ensure the application has started/stopped on this day.

### Directory structure

If today is Thursday, the directory structure will be:

```
.
|-- Fri
|-- Mon
|-- Thu
|-- Tue
|-- Wed
|-- today -> Thu
`-- yesterday -> Wed
```

### Syntax

```
rotate.sh - daily logs rotation
Syntax:
   rotate.sh [-h|--help] [-f|--full] [-k|--keep] <path>

-h|--help : this help.
-f|--full : use a 7-days week instead of a business week of 5 days.
-k|--keep : keep the content of today's directory (default: purge).
```

*--full*
> when specified, create directories from Monday to Sunday, 
> otherwise only from Monday to Friday.

*--keep*
> When specified, do not purge the directory pointed by the
> symbolic link `today`.

### Usage

Normally the script is run as a daily cron job, early in the morning, before the start of the
application.

``` bash
# logs rotation every day at 5am from Monday to Friday
00 05 * * 1-5 ${HOME}/scripts/rotate.sh ${HOME}/acme-app/logs >/dev/null 2>&1

# start the application at 6am
00 06 * * 1-5 ${HOME}/acme-app/bin/start.sh >${HOME}/acme-app/logs/today/start.log 2>&1
```
