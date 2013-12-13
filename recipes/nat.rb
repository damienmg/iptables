#
# Cookbook Name:: iptables
# Recipe:: nat
#
# Copyright 2013, iQSpot
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Export NAT rules
# Provide it with a node['iptables']['nat'] variables that contains an array
# of network:
#   interface => the interface to nat, e.g., eth1
#   network => the network to nat, e.g., 192.168.0.0/24
#   output => the output interface to forward to, e.g., eth0

package "iptables"

include_recipe "sysctl"

if node['iptables']['nat'] then
  sysctl_param "net.ipv4.ip_forward" do
    value 1
  end

  iptables_rule "nat" do
    variables({ "network" => node['iptables']['nat'] })
  end
end
