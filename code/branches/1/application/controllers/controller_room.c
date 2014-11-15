#include "benben.h"
#include "bsocket.h"
#include "model.h"

void controller_room_tables(bmessage_t* pMsg)
{
	bresponse_t response = {0};
	char tables[ROOM_NAME_LEN+1] = {0};
	
	model_table_list(tables);
	
	bsocket_write_string(&response, tables, ROOM_NAME_LEN+1);
	bsocket_flush(pMsg, &response);
}