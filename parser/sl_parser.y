//part I
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#define ID_SIZE 100
#define MAX_CHILDREN 3
#define STATEMENT 500//just so this prints out when a stat is read in

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
int debug = 1;

/* attach an existing node onto a parent */
void attach_node(struct Node* parent, struct Node* child) {
  /* connect it */
  parent->children[parent->num_children] = child;
  parent->num_children++;
  assert(parent->num_children <= MAX_CHILDREN);
}	

struct Node* tree;

%}


//part II

%union { char* char_array; struct Node * node; double Double;}

%start program
%token <char_array> IDENTIFIER 	100
%token <Double> VALUE	 		101
%token PLUS    					102
%token MINUS   					103
%token DIVIDE  					104
%token TIMES        			105
%token LESS       				106
%token GREATER    				107
%token LESSEQ      				108
%token GREATEREQ   				109
%token EQUALS   				110
%token NEQUALS       			111
%token AND     					112
%token OR      					113
%token NOT     					114
%token SEMICOLON 		   		115
%token ASSIGN       			116
%token OPEN_PARENS     			117
%token CLOSE_PARENS    			118
%token START   					119
%token END     					120
%token IF      					121
%token THEN    					122
%token ELSE    					123
%token WHILE   					124
%token DO      					125
%token PRINT   					126
%token INPUT   					127

%type <node> if not_expr multdiv_expr plusmin_expr conditional_expr and_expr or_expr assign stat ifelse while print seq value program stats paren_expr identifier
%error-verbose
%%
//part III

stat: assign           { $$=$1;}
	| if               { $$=$1;}
	| ifelse           { $$=$1;}
	| while            { $$=$1;}
	| print            { $$=$1;}
	| seq              { $$=$1;}




/* operators in order of precedence */
paren_expr: OPEN_PARENS paren_expr CLOSE_PARENS {
		  if(debug==1) printf("paren_expr\n");
		  $$=$2;
		  }
		  | value {
		  if(debug==1) printf("going up to value\n");
		  $$ = $1;
		  }

	 	| identifier 
			{
				if(debug==1)printf("identifier");
				$$=make_node(IDENTIFIER, 0, yylval.char_array);
			} 


not_expr: NOT not_expr 
					{
						if(debug==1)printf("not_expr\n");
						$$ = make_node(NOT, 0, "");
						attach_node($$, $2);  
						/* not should always be to the left of a statement*/
					} 
				| paren_expr {
				if(debug==1)printf("going up\n");
				$$ = $1;}




multdiv_expr: multdiv_expr TIMES not_expr
					{
						if(debug==1)printf("mult_expr\n");
						$$=make_node(TIMES, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}

				| multdiv_expr DIVIDE not_expr
					{
						if(debug==1)printf("div_expr\n");
						$$=make_node(DIVIDE, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					} 
				| not_expr {
				if(debug==1)printf("going up\n");
				$$ = $1;}	




plusmin_expr: plusmin_expr PLUS multdiv_expr
					{

						if(debug==1)printf("plus_expr\n");
						$$=make_node(PLUS, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);

					}
				| plusmin_expr MINUS multdiv_expr 

					{
						if(debug==1)printf("min_expr\n");
						$$=make_node(MINUS, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| multdiv_expr {
			if(debug==1)	printf("going up\n");
				$$ = $1;}




conditional_expr: conditional_expr GREATER plusmin_expr
					{
						if(debug==1)printf("greater\n");
						$$=make_node(GREATER, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}

				| conditional_expr LESS plusmin_expr
					{
						if(debug==1)printf("less\n");
						$$=make_node(LESS, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| conditional_expr GREATEREQ plusmin_expr
					{
						if(debug==1)printf("greatereq\n");
						$$=make_node(GREATEREQ, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| conditional_expr LESSEQ plusmin_expr
					{
						if(debug==1)printf("lesseq\n");
						$$=make_node(LESSEQ, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| conditional_expr EQUALS plusmin_expr
					{
						if(debug==1)printf("equals\n");
						$$=make_node(EQUALS, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| conditional_expr NEQUALS plusmin_expr
					{
						if(debug==1)printf("nequals\n");
						$$=make_node(NEQUALS, 0, "");
						attach_node($$, $1);
						attach_node($$, $3);
					}
				| plusmin_expr {
				if(debug==1)printf("going up\n");
				$$ = $1;}



and_expr: and_expr AND conditional_expr 
				{
					if(debug==1)printf("and\n");
					$$ = make_node(AND, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);
				}
			| conditional_expr {
			if(debug==1)printf("going up\n");
			$$=$1;}



or_expr: or_expr OR and_expr 
				{ 
					if(debug==1)printf("or\n");
					$$ = make_node(OR, 0, "");
					attach_node($$, $1);
					attach_node($$, $3);

				}
			| and_expr {
			if(debug==1)printf("going up\n");
			$$ = $1;}



/* no precedence to worry about from here down */
if: IF or_expr THEN stat 
				{
					if(debug==1)printf("if\n");
					$$ = make_node(IF, 0, "");
					attach_node($$, $2);
					attach_node($$, $4);
				}



assign: identifier ASSIGN or_expr SEMICOLON 
				{
					fflush(stdout);
					if(debug==1)printf("assign\n");
					$$ = make_node(ASSIGN, 0 ,"");
					if(debug==1)printf("makes the assignment node");
					fflush(stdout);
					if(debug==1)printf("created node\n");
					fflush(stdout);
					attach_node($$, $1); //adds identifier to the tree
					if(debug==1)printf("attached node\n");
					fflush(stdout);
					attach_node($$, $3); //adds stat to the tree
					if(debug==1)printf("attached or");
					fflush(stdout);
				}


ifelse: IF or_expr THEN stat ELSE stat
				{
					if(debug==1)printf("ifelse\n");
					$$ = make_node(IF, 0, "");
					attach_node($$, $2); //adds identifier to the tree
					attach_node($$, $4); //adds stat to the tree

					$$ = make_node(ELSE, 0, "");
					attach_node($$, $6); //adds identifier to the tree
				}


while: WHILE or_expr DO stat
				{
					if(debug==1)printf("while\n");
					$$ = make_node(WHILE, 0, "");
					attach_node($$, $2);
					attach_node($$, $4);
				}


print: PRINT or_expr SEMICOLON
				{
					if(debug==1)printf("print\n");
					$$=make_node(PRINT, 0, ""); 
					attach_node($$, $2);
				}

value: VALUE
		 {
		 	if(debug==1)printf("val\n");
			 $$=make_node(VALUE, yylval.Double, "");
		 }
/*	 | IDENTIFIER 
		{
			if(debug==1)printf("identifier");
			$$=make_node(IDENTIFIER, 0, yylval.char_array);
		} */
	| INPUT
		{
			if(debug==1)printf("input");
			$$=make_node(INPUT, 0,"");
		}



seq: START stats END 
			{
				if(debug==1)printf("starting sequence");
				$$ = $2;
			}

stats: stat 
			 {
				if(debug==1)printf("Making a statement \n");
				$$ = make_node(STATEMENT, 0, "");
				attach_node($$, $1);
			 }
		 | stat stats
			 {
				if(debug==1)printf("Making statements\n");
				$$ = make_node(STATEMENT, 0, "");
				attach_node($$, $1);
				attach_node($$, $2);
			 }


program: stats 
		   {
			   if(debug==1)printf("IN PROGRAM\n");
			   tree = $1; 
			   if(debug==1)printf("added element to tree\n");
		   }

identifier: IDENTIFIER
		  {
		  	if(debug==1)printf("iden\n");
		  	$$ = make_node(IDENTIFIER, 0, yylval.char_array);
		  }

%%
void print_tree(struct Node* node, int tabs) {
  int i;
  if(debug==1)printf("entering print tree \n");	

  /* base case */
  if(!node){ printf("no node \n"); return;}

  /* print leading tabs */
  for(i = 0; i < tabs; i++) {
	 if(debug==1)printf("entering for loop \n");
	 printf("   " );
     if(debug==1)printf("end for loop \n");
	 fflush(stdout);
  }
  if(debug==1)printf("out of for loop\n");


  switch(node->type) {
    case IDENTIFIER : printf("IDENTIFIER: %s\n", node->id); break;
    case VALUE      : printf("VALUE: %lf\n", node->value); break;
    case PLUS       : printf("PLUS: \n"); break;
    case MINUS      : printf("MINUS: \n"); break;
    case DIVIDE     : printf("DIVIDE: \n"); break;
    case TIMES      : printf("TIMES: \n"); break;
    case LESS       : printf("LESS THAN: \n"); break;
    case GREATER    : printf("GREATER: \n"); break;
    case LESSEQ     : printf("LESS EQUAL: \n"); break;
    case GREATEREQ  : printf("GREATER EQUAL: \n"); break;
    case EQUALS     : printf("EQUALS: \n"); break;
    case NEQUALS    : printf("NOT EQUALS: \n"); break;
    case AND        : printf("AND: \n"); break;
    case OR         : printf("OR: \n"); break;
    case NOT        : printf("NOT: \n"); break;
    case ASSIGN     : printf("ASSIGN: \n"); break;
    case IF         : printf("IF: \n"); break;
    case WHILE      : printf("WHILE: \n"); break;
    case PRINT      : printf("PRINT: \n"); break;
    case INPUT      : printf("INPUT: \n"); break;
    case STATEMENT  : printf("STATEMENT: \n"); break;
    default:
      printf("Error, %d not a valid node type.\n", node->type);
      exit(1);
  }

  /* print all children nodes underneath */
  for(i = 0; i < node->num_children; i++) {
 if(debug==1) 	printf("in for at element %d \n", i );
    print_tree(node->children[i], tabs + 1);
  }
}

int yywrap( ) {
  return 1;
}

void yyerror(const char* str) {
  fprintf(stderr, "Compiler error: '%s'.\n", str);
}

int main(int argc, char* argv[])
{ 

if(debug==1)	printf("In main \n");
    stdin = fopen(argv[1], "r");    

//    int :`oken;
    
//	do {token = yylex( ); printf("token \n");} while(token != 0);

	//tree = yyparse();
	yyparse();
	print_tree(tree, 1);// (tree to feed in, num tabs it will print out with) 
if(debug==1)	printf("leaving main \n");
	return 0; 
}
