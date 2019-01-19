lspci -nnk | grep ' VGA ' | cut -d" " -f 1 | xargs -i lspci -nnk -v -s {}
