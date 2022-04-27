
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  2e:	00001d97          	auipc	s11,0x1
  32:	a4bd8d93          	addi	s11,s11,-1461 # a79 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	978a0a13          	addi	s4,s4,-1672 # 9b0 <malloc+0xea>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	276080e7          	jalr	630(ra) # 2bc <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2b85                	addiw	s7,s7,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c05                	addiw	s8,s8,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	a0258593          	addi	a1,a1,-1534 # a78 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	42a080e7          	jalr	1066(ra) # 4ac <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	9ea48493          	addi	s1,s1,-1558 # a78 <buf>
  96:	00050d1b          	sext.w	s10,a0
  9a:	fff5091b          	addiw	s2,a0,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86e6                	mv	a3,s9
  b2:	8662                	mv	a2,s8
  b4:	85de                	mv	a1,s7
  b6:	00001517          	auipc	a0,0x1
  ba:	91250513          	addi	a0,a0,-1774 # 9c8 <malloc+0x102>
  be:	00000097          	auipc	ra,0x0
  c2:	750080e7          	jalr	1872(ra) # 80e <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	8d450513          	addi	a0,a0,-1836 # 9b8 <malloc+0xf2>
  ec:	00000097          	auipc	ra,0x0
  f0:	722080e7          	jalr	1826(ra) # 80e <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	39e080e7          	jalr	926(ra) # 494 <exit>

00000000000000fe <main>:

int
main(int argc, char *argv[])
{
  fe:	7179                	addi	sp,sp,-48
 100:	f406                	sd	ra,40(sp)
 102:	f022                	sd	s0,32(sp)
 104:	ec26                	sd	s1,24(sp)
 106:	e84a                	sd	s2,16(sp)
 108:	e44e                	sd	s3,8(sp)
 10a:	e052                	sd	s4,0(sp)
 10c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 10e:	4785                	li	a5,1
 110:	04a7d763          	bge	a5,a0,15e <main+0x60>
 114:	00858493          	addi	s1,a1,8
 118:	ffe5099b          	addiw	s3,a0,-2
 11c:	02099793          	slli	a5,s3,0x20
 120:	01d7d993          	srli	s3,a5,0x1d
 124:	05c1                	addi	a1,a1,16
 126:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 128:	4581                	li	a1,0
 12a:	6088                	ld	a0,0(s1)
 12c:	00000097          	auipc	ra,0x0
 130:	3a8080e7          	jalr	936(ra) # 4d4 <open>
 134:	892a                	mv	s2,a0
 136:	04054263          	bltz	a0,17a <main+0x7c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 13a:	608c                	ld	a1,0(s1)
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <wc>
    close(fd);
 144:	854a                	mv	a0,s2
 146:	00000097          	auipc	ra,0x0
 14a:	376080e7          	jalr	886(ra) # 4bc <close>
  for(i = 1; i < argc; i++){
 14e:	04a1                	addi	s1,s1,8
 150:	fd349ce3          	bne	s1,s3,128 <main+0x2a>
  }
  exit(0);
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	33e080e7          	jalr	830(ra) # 494 <exit>
    wc(0, "");
 15e:	00001597          	auipc	a1,0x1
 162:	87a58593          	addi	a1,a1,-1926 # 9d8 <malloc+0x112>
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	e98080e7          	jalr	-360(ra) # 0 <wc>
    exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	322080e7          	jalr	802(ra) # 494 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 17a:	608c                	ld	a1,0(s1)
 17c:	00001517          	auipc	a0,0x1
 180:	86450513          	addi	a0,a0,-1948 # 9e0 <malloc+0x11a>
 184:	00000097          	auipc	ra,0x0
 188:	68a080e7          	jalr	1674(ra) # 80e <printf>
      exit(1);
 18c:	4505                	li	a0,1
 18e:	00000097          	auipc	ra,0x0
 192:	306080e7          	jalr	774(ra) # 494 <exit>

0000000000000196 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19c:	87aa                	mv	a5,a0
 19e:	0585                	addi	a1,a1,1
 1a0:	0785                	addi	a5,a5,1
 1a2:	fff5c703          	lbu	a4,-1(a1)
 1a6:	fee78fa3          	sb	a4,-1(a5)
 1aa:	fb75                	bnez	a4,19e <strcpy+0x8>
    ;
  return os;
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	addi	sp,sp,16
 1b0:	8082                	ret

00000000000001b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b2:	1141                	addi	sp,sp,-16
 1b4:	e422                	sd	s0,8(sp)
 1b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cb91                	beqz	a5,1d0 <strcmp+0x1e>
 1be:	0005c703          	lbu	a4,0(a1)
 1c2:	00f71763          	bne	a4,a5,1d0 <strcmp+0x1e>
    p++, q++;
 1c6:	0505                	addi	a0,a0,1
 1c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbe5                	bnez	a5,1be <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d0:	0005c503          	lbu	a0,0(a1)
}
 1d4:	40a7853b          	subw	a0,a5,a0
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cf91                	beqz	a5,204 <strlen+0x26>
 1ea:	0505                	addi	a0,a0,1
 1ec:	87aa                	mv	a5,a0
 1ee:	4685                	li	a3,1
 1f0:	9e89                	subw	a3,a3,a0
 1f2:	00f6853b          	addw	a0,a3,a5
 1f6:	0785                	addi	a5,a5,1
 1f8:	fff7c703          	lbu	a4,-1(a5)
 1fc:	fb7d                	bnez	a4,1f2 <strlen+0x14>
    ;
  return n;
}
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
  for(n = 0; s[n]; n++)
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <strlen+0x20>

0000000000000208 <strsub>:
int strsub(const char *s, const char *sub){
 208:	7139                	addi	sp,sp,-64
 20a:	fc06                	sd	ra,56(sp)
 20c:	f822                	sd	s0,48(sp)
 20e:	f426                	sd	s1,40(sp)
 210:	f04a                	sd	s2,32(sp)
 212:	ec4e                	sd	s3,24(sp)
 214:	e852                	sd	s4,16(sp)
 216:	e456                	sd	s5,8(sp)
 218:	0080                	addi	s0,sp,64
 21a:	8a2a                	mv	s4,a0
 21c:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 21e:	84aa                	mv	s1,a0
 220:	4901                	li	s2,0
 222:	a019                	j	228 <strsub+0x20>
 224:	2905                	addiw	s2,s2,1
 226:	0485                	addi	s1,s1,1
 228:	8552                	mv	a0,s4
 22a:	00000097          	auipc	ra,0x0
 22e:	fb4080e7          	jalr	-76(ra) # 1de <strlen>
 232:	2501                	sext.w	a0,a0
 234:	04a97863          	bgeu	s2,a0,284 <strsub+0x7c>
    if(s[i] == sub[0]){
 238:	8aa6                	mv	s5,s1
 23a:	0004c703          	lbu	a4,0(s1)
 23e:	0009c783          	lbu	a5,0(s3)
 242:	fef711e3          	bne	a4,a5,224 <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 246:	854e                	mv	a0,s3
 248:	00000097          	auipc	ra,0x0
 24c:	f96080e7          	jalr	-106(ra) # 1de <strlen>
 250:	0005059b          	sext.w	a1,a0
 254:	ffe5061b          	addiw	a2,a0,-2
 258:	1602                	slli	a2,a2,0x20
 25a:	9201                	srli	a2,a2,0x20
 25c:	0609                	addi	a2,a2,2
 25e:	4785                	li	a5,1
 260:	0007871b          	sext.w	a4,a5
 264:	fcb770e3          	bgeu	a4,a1,224 <strsub+0x1c>
        if(s[j+i] != sub[j]){
 268:	00fa86b3          	add	a3,s5,a5
 26c:	00f98733          	add	a4,s3,a5
 270:	0006c683          	lbu	a3,0(a3)
 274:	00074703          	lbu	a4,0(a4)
 278:	fae696e3          	bne	a3,a4,224 <strsub+0x1c>
        if(j == strlen(sub) -1){
 27c:	0785                	addi	a5,a5,1
 27e:	fec791e3          	bne	a5,a2,260 <strsub+0x58>
 282:	a011                	j	286 <strsub+0x7e>
  return -1;
 284:	597d                	li	s2,-1
}
 286:	854a                	mv	a0,s2
 288:	70e2                	ld	ra,56(sp)
 28a:	7442                	ld	s0,48(sp)
 28c:	74a2                	ld	s1,40(sp)
 28e:	7902                	ld	s2,32(sp)
 290:	69e2                	ld	s3,24(sp)
 292:	6a42                	ld	s4,16(sp)
 294:	6aa2                	ld	s5,8(sp)
 296:	6121                	addi	sp,sp,64
 298:	8082                	ret

000000000000029a <memset>:

void*
memset(void *dst, int c, uint n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2a0:	ca19                	beqz	a2,2b6 <memset+0x1c>
 2a2:	87aa                	mv	a5,a0
 2a4:	1602                	slli	a2,a2,0x20
 2a6:	9201                	srli	a2,a2,0x20
 2a8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2ac:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2b0:	0785                	addi	a5,a5,1
 2b2:	fee79de3          	bne	a5,a4,2ac <memset+0x12>
  }
  return dst;
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strchr>:

char*
strchr(const char *s, char c)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cb99                	beqz	a5,2dc <strchr+0x20>
    if(*s == c)
 2c8:	00f58763          	beq	a1,a5,2d6 <strchr+0x1a>
  for(; *s; s++)
 2cc:	0505                	addi	a0,a0,1
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	fbfd                	bnez	a5,2c8 <strchr+0xc>
      return (char*)s;
  return 0;
 2d4:	4501                	li	a0,0
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
  return 0;
 2dc:	4501                	li	a0,0
 2de:	bfe5                	j	2d6 <strchr+0x1a>

00000000000002e0 <gets>:

char*
gets(char *buf, int max)
{
 2e0:	711d                	addi	sp,sp,-96
 2e2:	ec86                	sd	ra,88(sp)
 2e4:	e8a2                	sd	s0,80(sp)
 2e6:	e4a6                	sd	s1,72(sp)
 2e8:	e0ca                	sd	s2,64(sp)
 2ea:	fc4e                	sd	s3,56(sp)
 2ec:	f852                	sd	s4,48(sp)
 2ee:	f456                	sd	s5,40(sp)
 2f0:	f05a                	sd	s6,32(sp)
 2f2:	ec5e                	sd	s7,24(sp)
 2f4:	1080                	addi	s0,sp,96
 2f6:	8baa                	mv	s7,a0
 2f8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2fa:	892a                	mv	s2,a0
 2fc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2fe:	4aa9                	li	s5,10
 300:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 302:	89a6                	mv	s3,s1
 304:	2485                	addiw	s1,s1,1
 306:	0344d863          	bge	s1,s4,336 <gets+0x56>
    cc = read(0, &c, 1);
 30a:	4605                	li	a2,1
 30c:	faf40593          	addi	a1,s0,-81
 310:	4501                	li	a0,0
 312:	00000097          	auipc	ra,0x0
 316:	19a080e7          	jalr	410(ra) # 4ac <read>
    if(cc < 1)
 31a:	00a05e63          	blez	a0,336 <gets+0x56>
    buf[i++] = c;
 31e:	faf44783          	lbu	a5,-81(s0)
 322:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 326:	01578763          	beq	a5,s5,334 <gets+0x54>
 32a:	0905                	addi	s2,s2,1
 32c:	fd679be3          	bne	a5,s6,302 <gets+0x22>
  for(i=0; i+1 < max; ){
 330:	89a6                	mv	s3,s1
 332:	a011                	j	336 <gets+0x56>
 334:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 336:	99de                	add	s3,s3,s7
 338:	00098023          	sb	zero,0(s3)
  return buf;
}
 33c:	855e                	mv	a0,s7
 33e:	60e6                	ld	ra,88(sp)
 340:	6446                	ld	s0,80(sp)
 342:	64a6                	ld	s1,72(sp)
 344:	6906                	ld	s2,64(sp)
 346:	79e2                	ld	s3,56(sp)
 348:	7a42                	ld	s4,48(sp)
 34a:	7aa2                	ld	s5,40(sp)
 34c:	7b02                	ld	s6,32(sp)
 34e:	6be2                	ld	s7,24(sp)
 350:	6125                	addi	sp,sp,96
 352:	8082                	ret

0000000000000354 <stat>:

int
stat(const char *n, struct stat *st)
{
 354:	1101                	addi	sp,sp,-32
 356:	ec06                	sd	ra,24(sp)
 358:	e822                	sd	s0,16(sp)
 35a:	e426                	sd	s1,8(sp)
 35c:	e04a                	sd	s2,0(sp)
 35e:	1000                	addi	s0,sp,32
 360:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 362:	4581                	li	a1,0
 364:	00000097          	auipc	ra,0x0
 368:	170080e7          	jalr	368(ra) # 4d4 <open>
  if(fd < 0)
 36c:	02054563          	bltz	a0,396 <stat+0x42>
 370:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 372:	85ca                	mv	a1,s2
 374:	00000097          	auipc	ra,0x0
 378:	178080e7          	jalr	376(ra) # 4ec <fstat>
 37c:	892a                	mv	s2,a0
  close(fd);
 37e:	8526                	mv	a0,s1
 380:	00000097          	auipc	ra,0x0
 384:	13c080e7          	jalr	316(ra) # 4bc <close>
  return r;
}
 388:	854a                	mv	a0,s2
 38a:	60e2                	ld	ra,24(sp)
 38c:	6442                	ld	s0,16(sp)
 38e:	64a2                	ld	s1,8(sp)
 390:	6902                	ld	s2,0(sp)
 392:	6105                	addi	sp,sp,32
 394:	8082                	ret
    return -1;
 396:	597d                	li	s2,-1
 398:	bfc5                	j	388 <stat+0x34>

000000000000039a <atoi>:

int
atoi(const char *s)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a0:	00054683          	lbu	a3,0(a0)
 3a4:	fd06879b          	addiw	a5,a3,-48
 3a8:	0ff7f793          	zext.b	a5,a5
 3ac:	4625                	li	a2,9
 3ae:	02f66863          	bltu	a2,a5,3de <atoi+0x44>
 3b2:	872a                	mv	a4,a0
  n = 0;
 3b4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3b6:	0705                	addi	a4,a4,1
 3b8:	0025179b          	slliw	a5,a0,0x2
 3bc:	9fa9                	addw	a5,a5,a0
 3be:	0017979b          	slliw	a5,a5,0x1
 3c2:	9fb5                	addw	a5,a5,a3
 3c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3c8:	00074683          	lbu	a3,0(a4)
 3cc:	fd06879b          	addiw	a5,a3,-48
 3d0:	0ff7f793          	zext.b	a5,a5
 3d4:	fef671e3          	bgeu	a2,a5,3b6 <atoi+0x1c>
  return n;
}
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	addi	sp,sp,16
 3dc:	8082                	ret
  n = 0;
 3de:	4501                	li	a0,0
 3e0:	bfe5                	j	3d8 <atoi+0x3e>

00000000000003e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e2:	1141                	addi	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3e8:	02b57463          	bgeu	a0,a1,410 <memmove+0x2e>
    while(n-- > 0)
 3ec:	00c05f63          	blez	a2,40a <memmove+0x28>
 3f0:	1602                	slli	a2,a2,0x20
 3f2:	9201                	srli	a2,a2,0x20
 3f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3f8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3fa:	0585                	addi	a1,a1,1
 3fc:	0705                	addi	a4,a4,1
 3fe:	fff5c683          	lbu	a3,-1(a1)
 402:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 406:	fee79ae3          	bne	a5,a4,3fa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 40a:	6422                	ld	s0,8(sp)
 40c:	0141                	addi	sp,sp,16
 40e:	8082                	ret
    dst += n;
 410:	00c50733          	add	a4,a0,a2
    src += n;
 414:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 416:	fec05ae3          	blez	a2,40a <memmove+0x28>
 41a:	fff6079b          	addiw	a5,a2,-1
 41e:	1782                	slli	a5,a5,0x20
 420:	9381                	srli	a5,a5,0x20
 422:	fff7c793          	not	a5,a5
 426:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 428:	15fd                	addi	a1,a1,-1
 42a:	177d                	addi	a4,a4,-1
 42c:	0005c683          	lbu	a3,0(a1)
 430:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 434:	fee79ae3          	bne	a5,a4,428 <memmove+0x46>
 438:	bfc9                	j	40a <memmove+0x28>

000000000000043a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 440:	ca05                	beqz	a2,470 <memcmp+0x36>
 442:	fff6069b          	addiw	a3,a2,-1
 446:	1682                	slli	a3,a3,0x20
 448:	9281                	srli	a3,a3,0x20
 44a:	0685                	addi	a3,a3,1
 44c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 44e:	00054783          	lbu	a5,0(a0)
 452:	0005c703          	lbu	a4,0(a1)
 456:	00e79863          	bne	a5,a4,466 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 45a:	0505                	addi	a0,a0,1
    p2++;
 45c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 45e:	fed518e3          	bne	a0,a3,44e <memcmp+0x14>
  }
  return 0;
 462:	4501                	li	a0,0
 464:	a019                	j	46a <memcmp+0x30>
      return *p1 - *p2;
 466:	40e7853b          	subw	a0,a5,a4
}
 46a:	6422                	ld	s0,8(sp)
 46c:	0141                	addi	sp,sp,16
 46e:	8082                	ret
  return 0;
 470:	4501                	li	a0,0
 472:	bfe5                	j	46a <memcmp+0x30>

0000000000000474 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 474:	1141                	addi	sp,sp,-16
 476:	e406                	sd	ra,8(sp)
 478:	e022                	sd	s0,0(sp)
 47a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 47c:	00000097          	auipc	ra,0x0
 480:	f66080e7          	jalr	-154(ra) # 3e2 <memmove>
}
 484:	60a2                	ld	ra,8(sp)
 486:	6402                	ld	s0,0(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret

000000000000048c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 48c:	4885                	li	a7,1
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <exit>:
.global exit
exit:
 li a7, SYS_exit
 494:	4889                	li	a7,2
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <wait>:
.global wait
wait:
 li a7, SYS_wait
 49c:	488d                	li	a7,3
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4a4:	4891                	li	a7,4
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <read>:
.global read
read:
 li a7, SYS_read
 4ac:	4895                	li	a7,5
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <write>:
.global write
write:
 li a7, SYS_write
 4b4:	48c1                	li	a7,16
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <close>:
.global close
close:
 li a7, SYS_close
 4bc:	48d5                	li	a7,21
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4c4:	4899                	li	a7,6
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 4cc:	489d                	li	a7,7
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <open>:
.global open
open:
 li a7, SYS_open
 4d4:	48bd                	li	a7,15
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4dc:	48c5                	li	a7,17
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4e4:	48c9                	li	a7,18
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4ec:	48a1                	li	a7,8
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <link>:
.global link
link:
 li a7, SYS_link
 4f4:	48cd                	li	a7,19
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4fc:	48d1                	li	a7,20
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 504:	48a5                	li	a7,9
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <dup>:
.global dup
dup:
 li a7, SYS_dup
 50c:	48a9                	li	a7,10
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 514:	48ad                	li	a7,11
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 51c:	48b1                	li	a7,12
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 524:	48b5                	li	a7,13
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 52c:	48b9                	li	a7,14
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 534:	1101                	addi	sp,sp,-32
 536:	ec06                	sd	ra,24(sp)
 538:	e822                	sd	s0,16(sp)
 53a:	1000                	addi	s0,sp,32
 53c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 540:	4605                	li	a2,1
 542:	fef40593          	addi	a1,s0,-17
 546:	00000097          	auipc	ra,0x0
 54a:	f6e080e7          	jalr	-146(ra) # 4b4 <write>
}
 54e:	60e2                	ld	ra,24(sp)
 550:	6442                	ld	s0,16(sp)
 552:	6105                	addi	sp,sp,32
 554:	8082                	ret

0000000000000556 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 556:	7139                	addi	sp,sp,-64
 558:	fc06                	sd	ra,56(sp)
 55a:	f822                	sd	s0,48(sp)
 55c:	f426                	sd	s1,40(sp)
 55e:	f04a                	sd	s2,32(sp)
 560:	ec4e                	sd	s3,24(sp)
 562:	0080                	addi	s0,sp,64
 564:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 566:	c299                	beqz	a3,56c <printint+0x16>
 568:	0805c963          	bltz	a1,5fa <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 56c:	2581                	sext.w	a1,a1
  neg = 0;
 56e:	4881                	li	a7,0
 570:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 574:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 576:	2601                	sext.w	a2,a2
 578:	00000517          	auipc	a0,0x0
 57c:	4e050513          	addi	a0,a0,1248 # a58 <digits>
 580:	883a                	mv	a6,a4
 582:	2705                	addiw	a4,a4,1
 584:	02c5f7bb          	remuw	a5,a1,a2
 588:	1782                	slli	a5,a5,0x20
 58a:	9381                	srli	a5,a5,0x20
 58c:	97aa                	add	a5,a5,a0
 58e:	0007c783          	lbu	a5,0(a5)
 592:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 596:	0005879b          	sext.w	a5,a1
 59a:	02c5d5bb          	divuw	a1,a1,a2
 59e:	0685                	addi	a3,a3,1
 5a0:	fec7f0e3          	bgeu	a5,a2,580 <printint+0x2a>
  if(neg)
 5a4:	00088c63          	beqz	a7,5bc <printint+0x66>
    buf[i++] = '-';
 5a8:	fd070793          	addi	a5,a4,-48
 5ac:	00878733          	add	a4,a5,s0
 5b0:	02d00793          	li	a5,45
 5b4:	fef70823          	sb	a5,-16(a4)
 5b8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5bc:	02e05863          	blez	a4,5ec <printint+0x96>
 5c0:	fc040793          	addi	a5,s0,-64
 5c4:	00e78933          	add	s2,a5,a4
 5c8:	fff78993          	addi	s3,a5,-1
 5cc:	99ba                	add	s3,s3,a4
 5ce:	377d                	addiw	a4,a4,-1
 5d0:	1702                	slli	a4,a4,0x20
 5d2:	9301                	srli	a4,a4,0x20
 5d4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5d8:	fff94583          	lbu	a1,-1(s2)
 5dc:	8526                	mv	a0,s1
 5de:	00000097          	auipc	ra,0x0
 5e2:	f56080e7          	jalr	-170(ra) # 534 <putc>
  while(--i >= 0)
 5e6:	197d                	addi	s2,s2,-1
 5e8:	ff3918e3          	bne	s2,s3,5d8 <printint+0x82>
}
 5ec:	70e2                	ld	ra,56(sp)
 5ee:	7442                	ld	s0,48(sp)
 5f0:	74a2                	ld	s1,40(sp)
 5f2:	7902                	ld	s2,32(sp)
 5f4:	69e2                	ld	s3,24(sp)
 5f6:	6121                	addi	sp,sp,64
 5f8:	8082                	ret
    x = -xx;
 5fa:	40b005bb          	negw	a1,a1
    neg = 1;
 5fe:	4885                	li	a7,1
    x = -xx;
 600:	bf85                	j	570 <printint+0x1a>

0000000000000602 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 602:	7119                	addi	sp,sp,-128
 604:	fc86                	sd	ra,120(sp)
 606:	f8a2                	sd	s0,112(sp)
 608:	f4a6                	sd	s1,104(sp)
 60a:	f0ca                	sd	s2,96(sp)
 60c:	ecce                	sd	s3,88(sp)
 60e:	e8d2                	sd	s4,80(sp)
 610:	e4d6                	sd	s5,72(sp)
 612:	e0da                	sd	s6,64(sp)
 614:	fc5e                	sd	s7,56(sp)
 616:	f862                	sd	s8,48(sp)
 618:	f466                	sd	s9,40(sp)
 61a:	f06a                	sd	s10,32(sp)
 61c:	ec6e                	sd	s11,24(sp)
 61e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 620:	0005c903          	lbu	s2,0(a1)
 624:	18090f63          	beqz	s2,7c2 <vprintf+0x1c0>
 628:	8aaa                	mv	s5,a0
 62a:	8b32                	mv	s6,a2
 62c:	00158493          	addi	s1,a1,1
  state = 0;
 630:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 632:	02500a13          	li	s4,37
 636:	4c55                	li	s8,21
 638:	00000c97          	auipc	s9,0x0
 63c:	3c8c8c93          	addi	s9,s9,968 # a00 <malloc+0x13a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 640:	02800d93          	li	s11,40
  putc(fd, 'x');
 644:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 646:	00000b97          	auipc	s7,0x0
 64a:	412b8b93          	addi	s7,s7,1042 # a58 <digits>
 64e:	a839                	j	66c <vprintf+0x6a>
        putc(fd, c);
 650:	85ca                	mv	a1,s2
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	ee0080e7          	jalr	-288(ra) # 534 <putc>
 65c:	a019                	j	662 <vprintf+0x60>
    } else if(state == '%'){
 65e:	01498d63          	beq	s3,s4,678 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 662:	0485                	addi	s1,s1,1
 664:	fff4c903          	lbu	s2,-1(s1)
 668:	14090d63          	beqz	s2,7c2 <vprintf+0x1c0>
    if(state == 0){
 66c:	fe0999e3          	bnez	s3,65e <vprintf+0x5c>
      if(c == '%'){
 670:	ff4910e3          	bne	s2,s4,650 <vprintf+0x4e>
        state = '%';
 674:	89d2                	mv	s3,s4
 676:	b7f5                	j	662 <vprintf+0x60>
      if(c == 'd'){
 678:	11490c63          	beq	s2,s4,790 <vprintf+0x18e>
 67c:	f9d9079b          	addiw	a5,s2,-99
 680:	0ff7f793          	zext.b	a5,a5
 684:	10fc6e63          	bltu	s8,a5,7a0 <vprintf+0x19e>
 688:	f9d9079b          	addiw	a5,s2,-99
 68c:	0ff7f713          	zext.b	a4,a5
 690:	10ec6863          	bltu	s8,a4,7a0 <vprintf+0x19e>
 694:	00271793          	slli	a5,a4,0x2
 698:	97e6                	add	a5,a5,s9
 69a:	439c                	lw	a5,0(a5)
 69c:	97e6                	add	a5,a5,s9
 69e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6a0:	008b0913          	addi	s2,s6,8
 6a4:	4685                	li	a3,1
 6a6:	4629                	li	a2,10
 6a8:	000b2583          	lw	a1,0(s6)
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	ea8080e7          	jalr	-344(ra) # 556 <printint>
 6b6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	b765                	j	662 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6bc:	008b0913          	addi	s2,s6,8
 6c0:	4681                	li	a3,0
 6c2:	4629                	li	a2,10
 6c4:	000b2583          	lw	a1,0(s6)
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e8c080e7          	jalr	-372(ra) # 556 <printint>
 6d2:	8b4a                	mv	s6,s2
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b771                	j	662 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6d8:	008b0913          	addi	s2,s6,8
 6dc:	4681                	li	a3,0
 6de:	866a                	mv	a2,s10
 6e0:	000b2583          	lw	a1,0(s6)
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e70080e7          	jalr	-400(ra) # 556 <printint>
 6ee:	8b4a                	mv	s6,s2
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	bf85                	j	662 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6f4:	008b0793          	addi	a5,s6,8
 6f8:	f8f43423          	sd	a5,-120(s0)
 6fc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 700:	03000593          	li	a1,48
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	e2e080e7          	jalr	-466(ra) # 534 <putc>
  putc(fd, 'x');
 70e:	07800593          	li	a1,120
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	e20080e7          	jalr	-480(ra) # 534 <putc>
 71c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71e:	03c9d793          	srli	a5,s3,0x3c
 722:	97de                	add	a5,a5,s7
 724:	0007c583          	lbu	a1,0(a5)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e0a080e7          	jalr	-502(ra) # 534 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 732:	0992                	slli	s3,s3,0x4
 734:	397d                	addiw	s2,s2,-1
 736:	fe0914e3          	bnez	s2,71e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 73a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 73e:	4981                	li	s3,0
 740:	b70d                	j	662 <vprintf+0x60>
        s = va_arg(ap, char*);
 742:	008b0913          	addi	s2,s6,8
 746:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 74a:	02098163          	beqz	s3,76c <vprintf+0x16a>
        while(*s != 0){
 74e:	0009c583          	lbu	a1,0(s3)
 752:	c5ad                	beqz	a1,7bc <vprintf+0x1ba>
          putc(fd, *s);
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	dde080e7          	jalr	-546(ra) # 534 <putc>
          s++;
 75e:	0985                	addi	s3,s3,1
        while(*s != 0){
 760:	0009c583          	lbu	a1,0(s3)
 764:	f9e5                	bnez	a1,754 <vprintf+0x152>
        s = va_arg(ap, char*);
 766:	8b4a                	mv	s6,s2
      state = 0;
 768:	4981                	li	s3,0
 76a:	bde5                	j	662 <vprintf+0x60>
          s = "(null)";
 76c:	00000997          	auipc	s3,0x0
 770:	28c98993          	addi	s3,s3,652 # 9f8 <malloc+0x132>
        while(*s != 0){
 774:	85ee                	mv	a1,s11
 776:	bff9                	j	754 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 778:	008b0913          	addi	s2,s6,8
 77c:	000b4583          	lbu	a1,0(s6)
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	db2080e7          	jalr	-590(ra) # 534 <putc>
 78a:	8b4a                	mv	s6,s2
      state = 0;
 78c:	4981                	li	s3,0
 78e:	bdd1                	j	662 <vprintf+0x60>
        putc(fd, c);
 790:	85d2                	mv	a1,s4
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	da0080e7          	jalr	-608(ra) # 534 <putc>
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b5d1                	j	662 <vprintf+0x60>
        putc(fd, '%');
 7a0:	85d2                	mv	a1,s4
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	d90080e7          	jalr	-624(ra) # 534 <putc>
        putc(fd, c);
 7ac:	85ca                	mv	a1,s2
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	d84080e7          	jalr	-636(ra) # 534 <putc>
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	b565                	j	662 <vprintf+0x60>
        s = va_arg(ap, char*);
 7bc:	8b4a                	mv	s6,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	b54d                	j	662 <vprintf+0x60>
    }
  }
}
 7c2:	70e6                	ld	ra,120(sp)
 7c4:	7446                	ld	s0,112(sp)
 7c6:	74a6                	ld	s1,104(sp)
 7c8:	7906                	ld	s2,96(sp)
 7ca:	69e6                	ld	s3,88(sp)
 7cc:	6a46                	ld	s4,80(sp)
 7ce:	6aa6                	ld	s5,72(sp)
 7d0:	6b06                	ld	s6,64(sp)
 7d2:	7be2                	ld	s7,56(sp)
 7d4:	7c42                	ld	s8,48(sp)
 7d6:	7ca2                	ld	s9,40(sp)
 7d8:	7d02                	ld	s10,32(sp)
 7da:	6de2                	ld	s11,24(sp)
 7dc:	6109                	addi	sp,sp,128
 7de:	8082                	ret

00000000000007e0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7e0:	715d                	addi	sp,sp,-80
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	addi	s0,sp,32
 7e8:	e010                	sd	a2,0(s0)
 7ea:	e414                	sd	a3,8(s0)
 7ec:	e818                	sd	a4,16(s0)
 7ee:	ec1c                	sd	a5,24(s0)
 7f0:	03043023          	sd	a6,32(s0)
 7f4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7f8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7fc:	8622                	mv	a2,s0
 7fe:	00000097          	auipc	ra,0x0
 802:	e04080e7          	jalr	-508(ra) # 602 <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6161                	addi	sp,sp,80
 80c:	8082                	ret

000000000000080e <printf>:

void
printf(const char *fmt, ...)
{
 80e:	711d                	addi	sp,sp,-96
 810:	ec06                	sd	ra,24(sp)
 812:	e822                	sd	s0,16(sp)
 814:	1000                	addi	s0,sp,32
 816:	e40c                	sd	a1,8(s0)
 818:	e810                	sd	a2,16(s0)
 81a:	ec14                	sd	a3,24(s0)
 81c:	f018                	sd	a4,32(s0)
 81e:	f41c                	sd	a5,40(s0)
 820:	03043823          	sd	a6,48(s0)
 824:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 828:	00840613          	addi	a2,s0,8
 82c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 830:	85aa                	mv	a1,a0
 832:	4505                	li	a0,1
 834:	00000097          	auipc	ra,0x0
 838:	dce080e7          	jalr	-562(ra) # 602 <vprintf>
}
 83c:	60e2                	ld	ra,24(sp)
 83e:	6442                	ld	s0,16(sp)
 840:	6125                	addi	sp,sp,96
 842:	8082                	ret

0000000000000844 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 844:	1141                	addi	sp,sp,-16
 846:	e422                	sd	s0,8(sp)
 848:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84e:	00000797          	auipc	a5,0x0
 852:	2227b783          	ld	a5,546(a5) # a70 <freep>
 856:	a02d                	j	880 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 858:	4618                	lw	a4,8(a2)
 85a:	9f2d                	addw	a4,a4,a1
 85c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 860:	6398                	ld	a4,0(a5)
 862:	6310                	ld	a2,0(a4)
 864:	a83d                	j	8a2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 866:	ff852703          	lw	a4,-8(a0)
 86a:	9f31                	addw	a4,a4,a2
 86c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 86e:	ff053683          	ld	a3,-16(a0)
 872:	a091                	j	8b6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 874:	6398                	ld	a4,0(a5)
 876:	00e7e463          	bltu	a5,a4,87e <free+0x3a>
 87a:	00e6ea63          	bltu	a3,a4,88e <free+0x4a>
{
 87e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 880:	fed7fae3          	bgeu	a5,a3,874 <free+0x30>
 884:	6398                	ld	a4,0(a5)
 886:	00e6e463          	bltu	a3,a4,88e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88a:	fee7eae3          	bltu	a5,a4,87e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 88e:	ff852583          	lw	a1,-8(a0)
 892:	6390                	ld	a2,0(a5)
 894:	02059813          	slli	a6,a1,0x20
 898:	01c85713          	srli	a4,a6,0x1c
 89c:	9736                	add	a4,a4,a3
 89e:	fae60de3          	beq	a2,a4,858 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8a2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8a6:	4790                	lw	a2,8(a5)
 8a8:	02061593          	slli	a1,a2,0x20
 8ac:	01c5d713          	srli	a4,a1,0x1c
 8b0:	973e                	add	a4,a4,a5
 8b2:	fae68ae3          	beq	a3,a4,866 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8b6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8b8:	00000717          	auipc	a4,0x0
 8bc:	1af73c23          	sd	a5,440(a4) # a70 <freep>
}
 8c0:	6422                	ld	s0,8(sp)
 8c2:	0141                	addi	sp,sp,16
 8c4:	8082                	ret

00000000000008c6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c6:	7139                	addi	sp,sp,-64
 8c8:	fc06                	sd	ra,56(sp)
 8ca:	f822                	sd	s0,48(sp)
 8cc:	f426                	sd	s1,40(sp)
 8ce:	f04a                	sd	s2,32(sp)
 8d0:	ec4e                	sd	s3,24(sp)
 8d2:	e852                	sd	s4,16(sp)
 8d4:	e456                	sd	s5,8(sp)
 8d6:	e05a                	sd	s6,0(sp)
 8d8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8da:	02051493          	slli	s1,a0,0x20
 8de:	9081                	srli	s1,s1,0x20
 8e0:	04bd                	addi	s1,s1,15
 8e2:	8091                	srli	s1,s1,0x4
 8e4:	0014899b          	addiw	s3,s1,1
 8e8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ea:	00000517          	auipc	a0,0x0
 8ee:	18653503          	ld	a0,390(a0) # a70 <freep>
 8f2:	c515                	beqz	a0,91e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f6:	4798                	lw	a4,8(a5)
 8f8:	02977f63          	bgeu	a4,s1,936 <malloc+0x70>
 8fc:	8a4e                	mv	s4,s3
 8fe:	0009871b          	sext.w	a4,s3
 902:	6685                	lui	a3,0x1
 904:	00d77363          	bgeu	a4,a3,90a <malloc+0x44>
 908:	6a05                	lui	s4,0x1
 90a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 90e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 912:	00000917          	auipc	s2,0x0
 916:	15e90913          	addi	s2,s2,350 # a70 <freep>
  if(p == (char*)-1)
 91a:	5afd                	li	s5,-1
 91c:	a895                	j	990 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 91e:	00000797          	auipc	a5,0x0
 922:	35a78793          	addi	a5,a5,858 # c78 <base>
 926:	00000717          	auipc	a4,0x0
 92a:	14f73523          	sd	a5,330(a4) # a70 <freep>
 92e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 930:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 934:	b7e1                	j	8fc <malloc+0x36>
      if(p->s.size == nunits)
 936:	02e48c63          	beq	s1,a4,96e <malloc+0xa8>
        p->s.size -= nunits;
 93a:	4137073b          	subw	a4,a4,s3
 93e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 940:	02071693          	slli	a3,a4,0x20
 944:	01c6d713          	srli	a4,a3,0x1c
 948:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 94a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 94e:	00000717          	auipc	a4,0x0
 952:	12a73123          	sd	a0,290(a4) # a70 <freep>
      return (void*)(p + 1);
 956:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 95a:	70e2                	ld	ra,56(sp)
 95c:	7442                	ld	s0,48(sp)
 95e:	74a2                	ld	s1,40(sp)
 960:	7902                	ld	s2,32(sp)
 962:	69e2                	ld	s3,24(sp)
 964:	6a42                	ld	s4,16(sp)
 966:	6aa2                	ld	s5,8(sp)
 968:	6b02                	ld	s6,0(sp)
 96a:	6121                	addi	sp,sp,64
 96c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 96e:	6398                	ld	a4,0(a5)
 970:	e118                	sd	a4,0(a0)
 972:	bff1                	j	94e <malloc+0x88>
  hp->s.size = nu;
 974:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 978:	0541                	addi	a0,a0,16
 97a:	00000097          	auipc	ra,0x0
 97e:	eca080e7          	jalr	-310(ra) # 844 <free>
  return freep;
 982:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 986:	d971                	beqz	a0,95a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 988:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98a:	4798                	lw	a4,8(a5)
 98c:	fa9775e3          	bgeu	a4,s1,936 <malloc+0x70>
    if(p == freep)
 990:	00093703          	ld	a4,0(s2)
 994:	853e                	mv	a0,a5
 996:	fef719e3          	bne	a4,a5,988 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 99a:	8552                	mv	a0,s4
 99c:	00000097          	auipc	ra,0x0
 9a0:	b80080e7          	jalr	-1152(ra) # 51c <sbrk>
  if(p == (char*)-1)
 9a4:	fd5518e3          	bne	a0,s5,974 <malloc+0xae>
        return 0;
 9a8:	4501                	li	a0,0
 9aa:	bf45                	j	95a <malloc+0x94>
