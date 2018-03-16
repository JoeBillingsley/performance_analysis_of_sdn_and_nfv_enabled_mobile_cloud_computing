//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#ifndef AGGREGATESWITCH_H_
#define AGGREGATESWITCH_H_

#include <omnetpp.h>

using namespace omnetpp;

namespace nfv_fattree {

class AggregateSwitch : public cSimpleModule
{
  private:
    int id, lb, ub;
    int num_ports, num_vm_ports, num_vms;
    int num_msg_received = 0;

    cQueue queue;
    simsignal_t received_cnt_signal;
    simsignal_t processed_signal;

  protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void finish();
};

} //namespace

#endif /* AGGREGATESWITCH_H_ */
