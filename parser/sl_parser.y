//part I
%{

#include <stdio.h>

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
}	

void print_tree(struct Node* node, int tabs) {
  int i;

  /* base case */
  if(!node) return;

  /* print leading tabs */
  for(i = 0; i < tabs; i++) {
     printf(" " + i + "  ");
  }

  switch(node->type) {
    case IDENTIFIER: printf("IDENTIFIER: %s\n", node->id); break;
    case VALUE: printf("VALUE: %lf\n", node->value); break;
    case PLUS: printf("PLUS:\n"); break;
    case MINUS: printf("MINUS:\n"); break;
    case DIVIDE: printf("DIVIDE:\n"); break;
    case TIMES: printf("TIMES:\n"); break;
    case LESS: printf("LESS THAN:\n"); break;
    case GREATER: printf("GREATER:\n"); break;
    case LESSEQ: printf("LESS EQUAL:\n"); break;
    case GREATEREQ: printf("GREATER EQUAL:\n"); break;
    case EQUALS: printf("EQUALS:\n"); break;
    case NEQUALS: printf("NOT EQUALS:\n"); break;
    case AND: printf("AND:\n"); break;
    case OR: printf("OR:\n"); break;
    case NOT: printf("NOT:\n"); break;
    case ASSIGN: printf("ASSIGN:\n"); break;
    case IF: printf("IF:\n"); break;
    case WHILE: printf("WHILE:\n"); break;
    case PRINT: printf("PRINT:\n"); break;
    case INPUT: printf("INPUT:\n"); break;
    case STATEMENT: printf("STATEMENT:\n"); break;
    default:
      printf("Error, %d not a valid node type.\n", node->type);
      exit(1);
  }

  /* print all children nodes underneath */
  for(i = 0; i < node->num_children; i++) {
    print_tree(node->children[i], tabs + 1);
  }
}

int main(){ print_tree(seq, 20); return 0; }

%}


//part II

%union { char* char_array; Node * node; double double;}

%start stat
%token IDENTIFIER      		100
%token VALUE  			 	101
%token <int>PLUS    				102
%token MINUS   				103
%token DIVIDE  				104
%token <int>TIMES        		105
%token LESS       			106
%token GREATER    			107
%token LESSEQ      			108
%token GREATEREQ   			109
%token EQUALS   			110
%token NEQUALS       		111
%token AND     				112
%token OR      				113
%token NOT     				114
%token SEMICOLON    		115
%token ASSIGN       		116
%token OPEN_PARENS     		117
%token CLOSE_PARENS    		118
%token START   				119
%token END     				120
%token IF      				121
%token THEN    				122
%token ELSE    				123
%token WHILE   				124
%token DO      				125
%token PRINT   				126
%token INPUT   				127

%type <node> if not_expr multdiv_expr plusmin_expr conditional_expr and_expr or_expr assign stat ifelse while print seq
%type <double> value
%type <char_array> identifier
%error-verbose

%%
//part III

//how do i take terminals into account?
//value is a problem since it is not of type Node
stat:not_expr 
	|multdiv_expr
	| plusmin_expr
	| conditional_expr
	| and_expr
	| or_expr
	| assign 
	| if
	| ifelse 
	| while 
	| print 
	| seq 
	| value
{
	attach_node($$, $1);
}

/* operators in order of precedence */
not_expr: NOT stat
{
	$$ = make_node(NOT, 0, "");
	attach_node($$, $2);  /* not should always be to the left of a statement*/
} 



/*these should always be to the right of some statment */

multdiv_expr: stat TIMES stat
			{

				$$=make_node(TIMES, 0, "");
				attach_node($$, $1);
				attach_node($$, $3);
			}

			| stat DIVIDE stat 
			{
				$$=make_node(DIVIDE, 0, "");
				attach_node($$, $1);
				attach_node($$, $3);
			} 

plusmin_expr: stat PLUS stat 
			{

				$$=make_node(PLUS, 0, "");
				attach_node($$, $1);
				attach_node($$, $3);

			}
			| stat MINUS stat 

			{
				$$=make_node(MINUS, 0, "");
				attach_node($$, $1);
				attach_node($$, $3);
			}

conditional_expr: stat GREATER stat
				{
					$$=make_node(GREATER, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}

				| stat LESS stat
				{
					$$=make_node(LESS, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}
				| stat GREATEREQ stat
				{
					$$=make_node(GREATEREQ, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}
				| stat LESSEQ stat
				{
					$$=make_node(LESSEQ, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}
				| stat EQUALS stat
				{
					$$=make_node(EQUALS, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}
				| stat NEQUALS stat
				{
					$$=make_node(NEQUALS, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}


and_expr: stat AND stat 
{
	$$ = make_node(AND, 0, "");
	attach_node($$, $1);
	attach_node($$, $3);
}

or_expr: stat OR stat 
{
	$$ = make_node(OR, 0, "");
	attach_node($$, $1);
	attach_node($$, $3);
}



/* no precedence to worry about from here down */
if: IF stat THEN stat 
{
	$$ = make_node(IF, 0, "");
	attach_node($$, $2);
	attach_node($$, $4);
}

assign: identifier EQUALS stat SEMICOLON 
{
	$$ = make_node(ASSIGN, 0 ,"");
	attach_node($$, $1); //adds identifier to the tree
	attach_node($$, $3); //adds stat to the tree
}

ifelse: IF stat THEN stat ELSE stat
{
	$$ = make_node(IF, 0, "");
	attach_node($$, $2); //adds identifier to the tree
	attach_node($$, $4); //adds stat to the tree

	$$ = make_node(ELSE, 0, "");
	attach_node($$, $6); //adds identifier to the tree
}

identifier: IDENTIFIER { $$ = make_node(IDENTIFIER, 0, "");}

while: WHILE stat DO stat
{
	$$ = make_node(WHILE, 0, "");
	attach_node($$, $2);
	attach_node($$, $4);
}

print: PRINT stat SEMICOLON
{
	$$=make_node(PRINT, 0, ""); 
	attach_node($$, $2);
}

value: VALUE{$$=make_node(VALUE, 0, "");} 

seq: START stat END { $$ = $2;}

