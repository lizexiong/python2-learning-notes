#!/bin/bash
RETVAL=0
#Check api status
chk_api () {
  api_status=$(ss -lntup | grep 5093)
  if [ "$api_status" != "" ];then
  return $RETVAL
  else
  RETVAL=1
  return $RETVAL
  fi
}
chk_api
