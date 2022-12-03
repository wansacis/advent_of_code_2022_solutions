#include <stdlib.h>
#include <stdio.h>

#define p int
p a(p * m, p n){
  p l = 1e7, li = -1;
  for(p i = 0; i++<n;)m[i]<l?(li=i),(l=m[i]):0;
  return li;
}

p main(p c, char** v){
  p n=0,x=0,s=0,m=0;
  c-1? n=atoi(v[1]):0;
  n<1?n=1:0;
  FILE *f=fopen("data","r");
  p *z=calloc(n, sizeof(p));
  while(!feof(f)){
    char v = fgetc(f);
    v-10?(x=x*10+v-48):x?((s+=x),(x=0)):((s>z[a(z,n)]?(z[a(z,n)]=s):0),(s=0));
  }
  for(p i=0;i++<n;)m+=z[i];
  printf("%d\n", m);
  return 0;
}
