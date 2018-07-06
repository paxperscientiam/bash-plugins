Not ready for primetime.


``` shell
for file in ~/.bash/plugins/*; do
    [ -r "$file" ] && source "$file"
done
unset file
```
