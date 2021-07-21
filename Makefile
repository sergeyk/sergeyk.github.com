serve:
	docker run --init -v`pwd`:/srv/jekyll -it --rm -p4000:4000 jekyll/jekyll:stable jekyll serve