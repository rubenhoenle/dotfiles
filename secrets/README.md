``` bash
AWS_ACCESS_KEY_ID=<MY_ACCESS_KEY>
AWS_SECRET_ACCESS_KEY=<MY_SECRET_ACCESS_KEY>
```

## Adding a new secret to agenix
``` bash
cd secrets
agenix -e secret1.age
```

## Adding a new SSH key to agenix
Add the new public key into `secrets.nix`.

``` bash
# rekey the secrets
agenix -r
```

