cp -a /vagrant/* .
if [[ ! -z $1 ]]; then
  ansible-playbook -vvv -i ./hosts ./${1}
fi

