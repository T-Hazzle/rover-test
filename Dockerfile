FROM ruby:2.3.1

RUN gem install circular_list

RUN export PATH=$PATH:/usr/local/bundle/bin/



WORKDIR /work
