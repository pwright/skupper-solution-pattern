#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

.NOTPARALLEL:

export PYTHONPATH := python

.PHONY: render
render: clean
		antora local-antora-playbook.yml
		./asciidoc-coalescer.rb --attribute overview-uml=null modules/crc.adoc > walkthroughs/crc/walkthrough.adoc
		cp docs/skupper/crc/_images/Overview.svg walkthroughs/crc/
		sed -i '/.*plantuml.*/c\image::Overview.svg[]' walkthroughs/crc/walkthrough.adoc
		./asciidoc-coalescer.rb --attribute overview-uml=null modules/ocp.adoc > walkthroughs/ocp/walkthrough.adoc
		cp docs/skupper/ocp/_images/Overview.svg walkthroughs/ocp/
		sed -i '/.*plantuml.*/c\image::Overview.svg[]' walkthroughs/ocp/walkthrough.adoc

.PHONY: clean
clean:
	rm -rf walkthroughs/*/walkthrough.adoc

