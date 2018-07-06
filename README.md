Not ready for primetime.


``` shell
for file in ~/.bash/plugins/*.bash; do
    [ -r "$file" ] && source "$file"
done
unset file
```
