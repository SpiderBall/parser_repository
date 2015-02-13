%{
#define ID_SIZE 100
#define MAX_CHILDREN 3

/* a tree node definition */
struct Node {
  /* the type of the node */
  int type;

  /* the value of the node if it can have one */
  double value;

  /* the id of the node (used for identifiers only) */
  char id[ID_SIZE];

  /* at most three children nodes */
  int num_children;
  struct Node* children[MAX_CHILDREN];
};


/* creates a new node and returns it */
struct Node* make_node(int type, double value, char* id) {
  int i;

  /* allocate space */
  struct Node* node = malloc(sizeof(struct Node));

  /* set properties */
  node->type = type;
  node->value = value;
  strcpy(node->id, id);
  node->num_children = 0;
  for(i = 0; i < MAX_CHILDREN; i++) {
    node->children[i] = NULL;
  }

  /* return new node */
  return node;
}

/* attach an existing node onto a parent */
void attach_node(struct Node* parent, struct Node* child) {
  /* connect it */
  parent->children[parent->num_children] = child;
  parent->num_children++;
  assert(parent->num_children <= MAX_CHILDREN);
%}

%token IDENTIFIER 100

%error-verbose
%union {
	
}

%%

/* grammar rules */

%%

/* C body section */
