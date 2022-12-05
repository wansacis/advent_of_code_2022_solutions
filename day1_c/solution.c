#include <stdlib.h>
#include <stdio.h>

int get_index_of_lowest(int * m, int sizeof_m){
  int l = 1e7, li = -1;
  for(int i = 0; i<sizeof_m;i++){
    if(m[i]<l){
      li = i;
      l=m[i];
    }
  }
  return li;
}

int main(int argc, char** argv){
  int n = 0, cur = 0, sum = 0, m = 0;
  if(argc > 1) n = atoi(argv[1]);
  if(n < 1) n = 1;
  FILE * fp = fopen("data","r");
  int *max = calloc(n, sizeof(int)); 
  while(!feof(fp)){
    char c = fgetc(fp);
    if(c != 10){
      cur = cur*10+(c-48);
    } else {
      if(cur == 0){
	int index = get_index_of_lowest(max, n);
	if(sum > max[index])  max[index] = sum;
	sum = 0;
      } else {
	sum += cur;
	cur = 0;
	}
    }
  }
  for(int i = 0; i<n;i++) m+=max[i];
  printf("answer: %d\n", m);
  fclose(fp);
  free(max);
  return 0;
}
