Mix of utility functions I've written or archived from the around the web.




``` shell
for file in ~/.bash/plugins/*.bash; do
    [ -r "$file" ] && source "$file"
done
unset file
```
