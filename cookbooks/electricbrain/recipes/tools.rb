#
# Cookbook Name:: electricbrain
# Recipe:: tools
#
# Copyright (c) 2016 Electric Brain Inc., All Rights Reserved.
#
# This recipe just installs a variety of programs that are convenient to have


packages = ["vim", "mercurial", "iotop", "graphviz", "sysstat", "git", "build-essential", "gcc","g++","curl","cmake","libreadline-dev", "git-core","libjpeg-dev", "libpng-dev","ncurses-dev","imagemagick","libzmq3-dev","gfortran","unzip","gnuplot","gnuplot-x11", "ipython","libopenblas-dev", "liblapack-dev"]

packages.each do |packageName|
    package packageName
end
