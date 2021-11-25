#!/bin/bash
# variables = var_accounts_passwords_pam_faillock_deny=3

if [ -f /usr/sbin/authconfig ]; then
    authconfig --enablefaillock --update
else
    authselect enable-feature with-faillock
fi
# Ensure the parameters only in /etc/security/faillock.conf
sed -i --follow-symlinks 's/\(pam_faillock.so \(preauth silent\|authfail\)\).*$/\1/g' /etc/pam.d/system-auth /etc/pam.d/password-auth
> /etc/security/faillock.conf
echo "deny=2" >> /etc/security/faillock.conf
echo "silent" >> /etc/security/faillock.conf
