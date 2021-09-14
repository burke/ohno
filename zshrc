if [[ ! -d /run/netns ]]; then
	/setup
  mkdir -p shopify/.shadowenv.d
  mkdir -p web/.shadowenv.d
  echo '(env/set "NAMESPACE" "shopify")' > shopify/.shadowenv.d/a.lisp
  echo '(env/set "NAMESPACE" "web")' > web/.shadowenv.d/a.lisp
fi

ptt() {
	if [[ -v NAMESPACE ]]; then
		nsenter --no-fork --net=/run/netns/$NAMESPACE /autons/test $$
	fi
}
eval "$(shadowenv init zsh)"
(cd shopify && shadowenv trust)
(cd web && shadowenv trust)

preexec_functions+=(ptt)
