bqueue_id_t messages_qid;

void message_queue_init()
{
	bqueue_init();
	messages_qid = bqueue_register(1000);
}

void message_queue_push(bmessage* pMsg)
{
	bqueue_node_push(messages_qid, pMsg);
}

void message_queue_pop()
{
	
}