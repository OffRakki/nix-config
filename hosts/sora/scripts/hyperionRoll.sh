for i in {1..100}; do
  echo key control+a | dotool && echo key control+v | dotool && echo key enter | dotool
  sleep 2
done
