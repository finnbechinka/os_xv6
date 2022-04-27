
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	90250513          	addi	a0,a0,-1790 # 910 <malloc+0xe8>
  16:	00000097          	auipc	ra,0x0
  1a:	420080e7          	jalr	1056(ra) # 436 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	44a080e7          	jalr	1098(ra) # 46e <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	440080e7          	jalr	1088(ra) # 46e <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	8e290913          	addi	s2,s2,-1822 # 918 <malloc+0xf0>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	730080e7          	jalr	1840(ra) # 770 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	3a6080e7          	jalr	934(ra) # 3ee <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	3a4080e7          	jalr	932(ra) # 3fe <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	8fe50513          	addi	a0,a0,-1794 # 968 <malloc+0x140>
  72:	00000097          	auipc	ra,0x0
  76:	6fe080e7          	jalr	1790(ra) # 770 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	37a080e7          	jalr	890(ra) # 3f6 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	88850513          	addi	a0,a0,-1912 # 910 <malloc+0xe8>
  90:	00000097          	auipc	ra,0x0
  94:	3ae080e7          	jalr	942(ra) # 43e <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	87650513          	addi	a0,a0,-1930 # 910 <malloc+0xe8>
  a2:	00000097          	auipc	ra,0x0
  a6:	394080e7          	jalr	916(ra) # 436 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	88450513          	addi	a0,a0,-1916 # 930 <malloc+0x108>
  b4:	00000097          	auipc	ra,0x0
  b8:	6bc080e7          	jalr	1724(ra) # 770 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	338080e7          	jalr	824(ra) # 3f6 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	93a58593          	addi	a1,a1,-1734 # a00 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	87a50513          	addi	a0,a0,-1926 # 948 <malloc+0x120>
  d6:	00000097          	auipc	ra,0x0
  da:	358080e7          	jalr	856(ra) # 42e <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	87250513          	addi	a0,a0,-1934 # 950 <malloc+0x128>
  e6:	00000097          	auipc	ra,0x0
  ea:	68a080e7          	jalr	1674(ra) # 770 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	306080e7          	jalr	774(ra) # 3f6 <exit>

00000000000000f8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fe:	87aa                	mv	a5,a0
 100:	0585                	addi	a1,a1,1
 102:	0785                	addi	a5,a5,1
 104:	fff5c703          	lbu	a4,-1(a1)
 108:	fee78fa3          	sb	a4,-1(a5)
 10c:	fb75                	bnez	a4,100 <strcpy+0x8>
    ;
  return os;
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret

0000000000000114 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	cb91                	beqz	a5,132 <strcmp+0x1e>
 120:	0005c703          	lbu	a4,0(a1)
 124:	00f71763          	bne	a4,a5,132 <strcmp+0x1e>
    p++, q++;
 128:	0505                	addi	a0,a0,1
 12a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 12c:	00054783          	lbu	a5,0(a0)
 130:	fbe5                	bnez	a5,120 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 132:	0005c503          	lbu	a0,0(a1)
}
 136:	40a7853b          	subw	a0,a5,a0
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret

0000000000000140 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 140:	1141                	addi	sp,sp,-16
 142:	e422                	sd	s0,8(sp)
 144:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 146:	00054783          	lbu	a5,0(a0)
 14a:	cf91                	beqz	a5,166 <strlen+0x26>
 14c:	0505                	addi	a0,a0,1
 14e:	87aa                	mv	a5,a0
 150:	4685                	li	a3,1
 152:	9e89                	subw	a3,a3,a0
 154:	00f6853b          	addw	a0,a3,a5
 158:	0785                	addi	a5,a5,1
 15a:	fff7c703          	lbu	a4,-1(a5)
 15e:	fb7d                	bnez	a4,154 <strlen+0x14>
    ;
  return n;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret
  for(n = 0; s[n]; n++)
 166:	4501                	li	a0,0
 168:	bfe5                	j	160 <strlen+0x20>

000000000000016a <strsub>:
int strsub(const char *s, const char *sub){
 16a:	7139                	addi	sp,sp,-64
 16c:	fc06                	sd	ra,56(sp)
 16e:	f822                	sd	s0,48(sp)
 170:	f426                	sd	s1,40(sp)
 172:	f04a                	sd	s2,32(sp)
 174:	ec4e                	sd	s3,24(sp)
 176:	e852                	sd	s4,16(sp)
 178:	e456                	sd	s5,8(sp)
 17a:	0080                	addi	s0,sp,64
 17c:	8a2a                	mv	s4,a0
 17e:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 180:	84aa                	mv	s1,a0
 182:	4901                	li	s2,0
 184:	a019                	j	18a <strsub+0x20>
 186:	2905                	addiw	s2,s2,1
 188:	0485                	addi	s1,s1,1
 18a:	8552                	mv	a0,s4
 18c:	00000097          	auipc	ra,0x0
 190:	fb4080e7          	jalr	-76(ra) # 140 <strlen>
 194:	2501                	sext.w	a0,a0
 196:	04a97863          	bgeu	s2,a0,1e6 <strsub+0x7c>
    if(s[i] == sub[0]){
 19a:	8aa6                	mv	s5,s1
 19c:	0004c703          	lbu	a4,0(s1)
 1a0:	0009c783          	lbu	a5,0(s3)
 1a4:	fef711e3          	bne	a4,a5,186 <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 1a8:	854e                	mv	a0,s3
 1aa:	00000097          	auipc	ra,0x0
 1ae:	f96080e7          	jalr	-106(ra) # 140 <strlen>
 1b2:	0005059b          	sext.w	a1,a0
 1b6:	ffe5061b          	addiw	a2,a0,-2
 1ba:	1602                	slli	a2,a2,0x20
 1bc:	9201                	srli	a2,a2,0x20
 1be:	0609                	addi	a2,a2,2
 1c0:	4785                	li	a5,1
 1c2:	0007871b          	sext.w	a4,a5
 1c6:	fcb770e3          	bgeu	a4,a1,186 <strsub+0x1c>
        if(s[j+i] != sub[j]){
 1ca:	00fa86b3          	add	a3,s5,a5
 1ce:	00f98733          	add	a4,s3,a5
 1d2:	0006c683          	lbu	a3,0(a3)
 1d6:	00074703          	lbu	a4,0(a4)
 1da:	fae696e3          	bne	a3,a4,186 <strsub+0x1c>
        if(j == strlen(sub) -1){
 1de:	0785                	addi	a5,a5,1
 1e0:	fec791e3          	bne	a5,a2,1c2 <strsub+0x58>
 1e4:	a011                	j	1e8 <strsub+0x7e>
  return -1;
 1e6:	597d                	li	s2,-1
}
 1e8:	854a                	mv	a0,s2
 1ea:	70e2                	ld	ra,56(sp)
 1ec:	7442                	ld	s0,48(sp)
 1ee:	74a2                	ld	s1,40(sp)
 1f0:	7902                	ld	s2,32(sp)
 1f2:	69e2                	ld	s3,24(sp)
 1f4:	6a42                	ld	s4,16(sp)
 1f6:	6aa2                	ld	s5,8(sp)
 1f8:	6121                	addi	sp,sp,64
 1fa:	8082                	ret

00000000000001fc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 202:	ca19                	beqz	a2,218 <memset+0x1c>
 204:	87aa                	mv	a5,a0
 206:	1602                	slli	a2,a2,0x20
 208:	9201                	srli	a2,a2,0x20
 20a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 20e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 212:	0785                	addi	a5,a5,1
 214:	fee79de3          	bne	a5,a4,20e <memset+0x12>
  }
  return dst;
}
 218:	6422                	ld	s0,8(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret

000000000000021e <strchr>:

char*
strchr(const char *s, char c)
{
 21e:	1141                	addi	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	addi	s0,sp,16
  for(; *s; s++)
 224:	00054783          	lbu	a5,0(a0)
 228:	cb99                	beqz	a5,23e <strchr+0x20>
    if(*s == c)
 22a:	00f58763          	beq	a1,a5,238 <strchr+0x1a>
  for(; *s; s++)
 22e:	0505                	addi	a0,a0,1
 230:	00054783          	lbu	a5,0(a0)
 234:	fbfd                	bnez	a5,22a <strchr+0xc>
      return (char*)s;
  return 0;
 236:	4501                	li	a0,0
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret
  return 0;
 23e:	4501                	li	a0,0
 240:	bfe5                	j	238 <strchr+0x1a>

0000000000000242 <gets>:

char*
gets(char *buf, int max)
{
 242:	711d                	addi	sp,sp,-96
 244:	ec86                	sd	ra,88(sp)
 246:	e8a2                	sd	s0,80(sp)
 248:	e4a6                	sd	s1,72(sp)
 24a:	e0ca                	sd	s2,64(sp)
 24c:	fc4e                	sd	s3,56(sp)
 24e:	f852                	sd	s4,48(sp)
 250:	f456                	sd	s5,40(sp)
 252:	f05a                	sd	s6,32(sp)
 254:	ec5e                	sd	s7,24(sp)
 256:	1080                	addi	s0,sp,96
 258:	8baa                	mv	s7,a0
 25a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25c:	892a                	mv	s2,a0
 25e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 260:	4aa9                	li	s5,10
 262:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 264:	89a6                	mv	s3,s1
 266:	2485                	addiw	s1,s1,1
 268:	0344d863          	bge	s1,s4,298 <gets+0x56>
    cc = read(0, &c, 1);
 26c:	4605                	li	a2,1
 26e:	faf40593          	addi	a1,s0,-81
 272:	4501                	li	a0,0
 274:	00000097          	auipc	ra,0x0
 278:	19a080e7          	jalr	410(ra) # 40e <read>
    if(cc < 1)
 27c:	00a05e63          	blez	a0,298 <gets+0x56>
    buf[i++] = c;
 280:	faf44783          	lbu	a5,-81(s0)
 284:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 288:	01578763          	beq	a5,s5,296 <gets+0x54>
 28c:	0905                	addi	s2,s2,1
 28e:	fd679be3          	bne	a5,s6,264 <gets+0x22>
  for(i=0; i+1 < max; ){
 292:	89a6                	mv	s3,s1
 294:	a011                	j	298 <gets+0x56>
 296:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 298:	99de                	add	s3,s3,s7
 29a:	00098023          	sb	zero,0(s3)
  return buf;
}
 29e:	855e                	mv	a0,s7
 2a0:	60e6                	ld	ra,88(sp)
 2a2:	6446                	ld	s0,80(sp)
 2a4:	64a6                	ld	s1,72(sp)
 2a6:	6906                	ld	s2,64(sp)
 2a8:	79e2                	ld	s3,56(sp)
 2aa:	7a42                	ld	s4,48(sp)
 2ac:	7aa2                	ld	s5,40(sp)
 2ae:	7b02                	ld	s6,32(sp)
 2b0:	6be2                	ld	s7,24(sp)
 2b2:	6125                	addi	sp,sp,96
 2b4:	8082                	ret

00000000000002b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b6:	1101                	addi	sp,sp,-32
 2b8:	ec06                	sd	ra,24(sp)
 2ba:	e822                	sd	s0,16(sp)
 2bc:	e426                	sd	s1,8(sp)
 2be:	e04a                	sd	s2,0(sp)
 2c0:	1000                	addi	s0,sp,32
 2c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c4:	4581                	li	a1,0
 2c6:	00000097          	auipc	ra,0x0
 2ca:	170080e7          	jalr	368(ra) # 436 <open>
  if(fd < 0)
 2ce:	02054563          	bltz	a0,2f8 <stat+0x42>
 2d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d4:	85ca                	mv	a1,s2
 2d6:	00000097          	auipc	ra,0x0
 2da:	178080e7          	jalr	376(ra) # 44e <fstat>
 2de:	892a                	mv	s2,a0
  close(fd);
 2e0:	8526                	mv	a0,s1
 2e2:	00000097          	auipc	ra,0x0
 2e6:	13c080e7          	jalr	316(ra) # 41e <close>
  return r;
}
 2ea:	854a                	mv	a0,s2
 2ec:	60e2                	ld	ra,24(sp)
 2ee:	6442                	ld	s0,16(sp)
 2f0:	64a2                	ld	s1,8(sp)
 2f2:	6902                	ld	s2,0(sp)
 2f4:	6105                	addi	sp,sp,32
 2f6:	8082                	ret
    return -1;
 2f8:	597d                	li	s2,-1
 2fa:	bfc5                	j	2ea <stat+0x34>

00000000000002fc <atoi>:

int
atoi(const char *s)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 302:	00054683          	lbu	a3,0(a0)
 306:	fd06879b          	addiw	a5,a3,-48
 30a:	0ff7f793          	zext.b	a5,a5
 30e:	4625                	li	a2,9
 310:	02f66863          	bltu	a2,a5,340 <atoi+0x44>
 314:	872a                	mv	a4,a0
  n = 0;
 316:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 318:	0705                	addi	a4,a4,1
 31a:	0025179b          	slliw	a5,a0,0x2
 31e:	9fa9                	addw	a5,a5,a0
 320:	0017979b          	slliw	a5,a5,0x1
 324:	9fb5                	addw	a5,a5,a3
 326:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 32a:	00074683          	lbu	a3,0(a4)
 32e:	fd06879b          	addiw	a5,a3,-48
 332:	0ff7f793          	zext.b	a5,a5
 336:	fef671e3          	bgeu	a2,a5,318 <atoi+0x1c>
  return n;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
  n = 0;
 340:	4501                	li	a0,0
 342:	bfe5                	j	33a <atoi+0x3e>

0000000000000344 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 344:	1141                	addi	sp,sp,-16
 346:	e422                	sd	s0,8(sp)
 348:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 34a:	02b57463          	bgeu	a0,a1,372 <memmove+0x2e>
    while(n-- > 0)
 34e:	00c05f63          	blez	a2,36c <memmove+0x28>
 352:	1602                	slli	a2,a2,0x20
 354:	9201                	srli	a2,a2,0x20
 356:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 35a:	872a                	mv	a4,a0
      *dst++ = *src++;
 35c:	0585                	addi	a1,a1,1
 35e:	0705                	addi	a4,a4,1
 360:	fff5c683          	lbu	a3,-1(a1)
 364:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 368:	fee79ae3          	bne	a5,a4,35c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
    dst += n;
 372:	00c50733          	add	a4,a0,a2
    src += n;
 376:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 378:	fec05ae3          	blez	a2,36c <memmove+0x28>
 37c:	fff6079b          	addiw	a5,a2,-1
 380:	1782                	slli	a5,a5,0x20
 382:	9381                	srli	a5,a5,0x20
 384:	fff7c793          	not	a5,a5
 388:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 38a:	15fd                	addi	a1,a1,-1
 38c:	177d                	addi	a4,a4,-1
 38e:	0005c683          	lbu	a3,0(a1)
 392:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 396:	fee79ae3          	bne	a5,a4,38a <memmove+0x46>
 39a:	bfc9                	j	36c <memmove+0x28>

000000000000039c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e422                	sd	s0,8(sp)
 3a0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3a2:	ca05                	beqz	a2,3d2 <memcmp+0x36>
 3a4:	fff6069b          	addiw	a3,a2,-1
 3a8:	1682                	slli	a3,a3,0x20
 3aa:	9281                	srli	a3,a3,0x20
 3ac:	0685                	addi	a3,a3,1
 3ae:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	0005c703          	lbu	a4,0(a1)
 3b8:	00e79863          	bne	a5,a4,3c8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3bc:	0505                	addi	a0,a0,1
    p2++;
 3be:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3c0:	fed518e3          	bne	a0,a3,3b0 <memcmp+0x14>
  }
  return 0;
 3c4:	4501                	li	a0,0
 3c6:	a019                	j	3cc <memcmp+0x30>
      return *p1 - *p2;
 3c8:	40e7853b          	subw	a0,a5,a4
}
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret
  return 0;
 3d2:	4501                	li	a0,0
 3d4:	bfe5                	j	3cc <memcmp+0x30>

00000000000003d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e406                	sd	ra,8(sp)
 3da:	e022                	sd	s0,0(sp)
 3dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3de:	00000097          	auipc	ra,0x0
 3e2:	f66080e7          	jalr	-154(ra) # 344 <memmove>
}
 3e6:	60a2                	ld	ra,8(sp)
 3e8:	6402                	ld	s0,0(sp)
 3ea:	0141                	addi	sp,sp,16
 3ec:	8082                	ret

00000000000003ee <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ee:	4885                	li	a7,1
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f6:	4889                	li	a7,2
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <wait>:
.global wait
wait:
 li a7, SYS_wait
 3fe:	488d                	li	a7,3
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 406:	4891                	li	a7,4
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <read>:
.global read
read:
 li a7, SYS_read
 40e:	4895                	li	a7,5
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <write>:
.global write
write:
 li a7, SYS_write
 416:	48c1                	li	a7,16
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <close>:
.global close
close:
 li a7, SYS_close
 41e:	48d5                	li	a7,21
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <kill>:
.global kill
kill:
 li a7, SYS_kill
 426:	4899                	li	a7,6
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <exec>:
.global exec
exec:
 li a7, SYS_exec
 42e:	489d                	li	a7,7
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <open>:
.global open
open:
 li a7, SYS_open
 436:	48bd                	li	a7,15
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 43e:	48c5                	li	a7,17
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 446:	48c9                	li	a7,18
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 44e:	48a1                	li	a7,8
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <link>:
.global link
link:
 li a7, SYS_link
 456:	48cd                	li	a7,19
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45e:	48d1                	li	a7,20
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 466:	48a5                	li	a7,9
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <dup>:
.global dup
dup:
 li a7, SYS_dup
 46e:	48a9                	li	a7,10
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 476:	48ad                	li	a7,11
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 47e:	48b1                	li	a7,12
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 486:	48b5                	li	a7,13
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48e:	48b9                	li	a7,14
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 496:	1101                	addi	sp,sp,-32
 498:	ec06                	sd	ra,24(sp)
 49a:	e822                	sd	s0,16(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	fef40593          	addi	a1,s0,-17
 4a8:	00000097          	auipc	ra,0x0
 4ac:	f6e080e7          	jalr	-146(ra) # 416 <write>
}
 4b0:	60e2                	ld	ra,24(sp)
 4b2:	6442                	ld	s0,16(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret

00000000000004b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b8:	7139                	addi	sp,sp,-64
 4ba:	fc06                	sd	ra,56(sp)
 4bc:	f822                	sd	s0,48(sp)
 4be:	f426                	sd	s1,40(sp)
 4c0:	f04a                	sd	s2,32(sp)
 4c2:	ec4e                	sd	s3,24(sp)
 4c4:	0080                	addi	s0,sp,64
 4c6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c8:	c299                	beqz	a3,4ce <printint+0x16>
 4ca:	0805c963          	bltz	a1,55c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ce:	2581                	sext.w	a1,a1
  neg = 0;
 4d0:	4881                	li	a7,0
 4d2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4d6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4d8:	2601                	sext.w	a2,a2
 4da:	00000517          	auipc	a0,0x0
 4de:	50e50513          	addi	a0,a0,1294 # 9e8 <digits>
 4e2:	883a                	mv	a6,a4
 4e4:	2705                	addiw	a4,a4,1
 4e6:	02c5f7bb          	remuw	a5,a1,a2
 4ea:	1782                	slli	a5,a5,0x20
 4ec:	9381                	srli	a5,a5,0x20
 4ee:	97aa                	add	a5,a5,a0
 4f0:	0007c783          	lbu	a5,0(a5)
 4f4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4f8:	0005879b          	sext.w	a5,a1
 4fc:	02c5d5bb          	divuw	a1,a1,a2
 500:	0685                	addi	a3,a3,1
 502:	fec7f0e3          	bgeu	a5,a2,4e2 <printint+0x2a>
  if(neg)
 506:	00088c63          	beqz	a7,51e <printint+0x66>
    buf[i++] = '-';
 50a:	fd070793          	addi	a5,a4,-48
 50e:	00878733          	add	a4,a5,s0
 512:	02d00793          	li	a5,45
 516:	fef70823          	sb	a5,-16(a4)
 51a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 51e:	02e05863          	blez	a4,54e <printint+0x96>
 522:	fc040793          	addi	a5,s0,-64
 526:	00e78933          	add	s2,a5,a4
 52a:	fff78993          	addi	s3,a5,-1
 52e:	99ba                	add	s3,s3,a4
 530:	377d                	addiw	a4,a4,-1
 532:	1702                	slli	a4,a4,0x20
 534:	9301                	srli	a4,a4,0x20
 536:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 53a:	fff94583          	lbu	a1,-1(s2)
 53e:	8526                	mv	a0,s1
 540:	00000097          	auipc	ra,0x0
 544:	f56080e7          	jalr	-170(ra) # 496 <putc>
  while(--i >= 0)
 548:	197d                	addi	s2,s2,-1
 54a:	ff3918e3          	bne	s2,s3,53a <printint+0x82>
}
 54e:	70e2                	ld	ra,56(sp)
 550:	7442                	ld	s0,48(sp)
 552:	74a2                	ld	s1,40(sp)
 554:	7902                	ld	s2,32(sp)
 556:	69e2                	ld	s3,24(sp)
 558:	6121                	addi	sp,sp,64
 55a:	8082                	ret
    x = -xx;
 55c:	40b005bb          	negw	a1,a1
    neg = 1;
 560:	4885                	li	a7,1
    x = -xx;
 562:	bf85                	j	4d2 <printint+0x1a>

0000000000000564 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 564:	7119                	addi	sp,sp,-128
 566:	fc86                	sd	ra,120(sp)
 568:	f8a2                	sd	s0,112(sp)
 56a:	f4a6                	sd	s1,104(sp)
 56c:	f0ca                	sd	s2,96(sp)
 56e:	ecce                	sd	s3,88(sp)
 570:	e8d2                	sd	s4,80(sp)
 572:	e4d6                	sd	s5,72(sp)
 574:	e0da                	sd	s6,64(sp)
 576:	fc5e                	sd	s7,56(sp)
 578:	f862                	sd	s8,48(sp)
 57a:	f466                	sd	s9,40(sp)
 57c:	f06a                	sd	s10,32(sp)
 57e:	ec6e                	sd	s11,24(sp)
 580:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 582:	0005c903          	lbu	s2,0(a1)
 586:	18090f63          	beqz	s2,724 <vprintf+0x1c0>
 58a:	8aaa                	mv	s5,a0
 58c:	8b32                	mv	s6,a2
 58e:	00158493          	addi	s1,a1,1
  state = 0;
 592:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 594:	02500a13          	li	s4,37
 598:	4c55                	li	s8,21
 59a:	00000c97          	auipc	s9,0x0
 59e:	3f6c8c93          	addi	s9,s9,1014 # 990 <malloc+0x168>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a2:	02800d93          	li	s11,40
  putc(fd, 'x');
 5a6:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a8:	00000b97          	auipc	s7,0x0
 5ac:	440b8b93          	addi	s7,s7,1088 # 9e8 <digits>
 5b0:	a839                	j	5ce <vprintf+0x6a>
        putc(fd, c);
 5b2:	85ca                	mv	a1,s2
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	ee0080e7          	jalr	-288(ra) # 496 <putc>
 5be:	a019                	j	5c4 <vprintf+0x60>
    } else if(state == '%'){
 5c0:	01498d63          	beq	s3,s4,5da <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5c4:	0485                	addi	s1,s1,1
 5c6:	fff4c903          	lbu	s2,-1(s1)
 5ca:	14090d63          	beqz	s2,724 <vprintf+0x1c0>
    if(state == 0){
 5ce:	fe0999e3          	bnez	s3,5c0 <vprintf+0x5c>
      if(c == '%'){
 5d2:	ff4910e3          	bne	s2,s4,5b2 <vprintf+0x4e>
        state = '%';
 5d6:	89d2                	mv	s3,s4
 5d8:	b7f5                	j	5c4 <vprintf+0x60>
      if(c == 'd'){
 5da:	11490c63          	beq	s2,s4,6f2 <vprintf+0x18e>
 5de:	f9d9079b          	addiw	a5,s2,-99
 5e2:	0ff7f793          	zext.b	a5,a5
 5e6:	10fc6e63          	bltu	s8,a5,702 <vprintf+0x19e>
 5ea:	f9d9079b          	addiw	a5,s2,-99
 5ee:	0ff7f713          	zext.b	a4,a5
 5f2:	10ec6863          	bltu	s8,a4,702 <vprintf+0x19e>
 5f6:	00271793          	slli	a5,a4,0x2
 5fa:	97e6                	add	a5,a5,s9
 5fc:	439c                	lw	a5,0(a5)
 5fe:	97e6                	add	a5,a5,s9
 600:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 602:	008b0913          	addi	s2,s6,8
 606:	4685                	li	a3,1
 608:	4629                	li	a2,10
 60a:	000b2583          	lw	a1,0(s6)
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	ea8080e7          	jalr	-344(ra) # 4b8 <printint>
 618:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b765                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	008b0913          	addi	s2,s6,8
 622:	4681                	li	a3,0
 624:	4629                	li	a2,10
 626:	000b2583          	lw	a1,0(s6)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e8c080e7          	jalr	-372(ra) # 4b8 <printint>
 634:	8b4a                	mv	s6,s2
      state = 0;
 636:	4981                	li	s3,0
 638:	b771                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 63a:	008b0913          	addi	s2,s6,8
 63e:	4681                	li	a3,0
 640:	866a                	mv	a2,s10
 642:	000b2583          	lw	a1,0(s6)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e70080e7          	jalr	-400(ra) # 4b8 <printint>
 650:	8b4a                	mv	s6,s2
      state = 0;
 652:	4981                	li	s3,0
 654:	bf85                	j	5c4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 656:	008b0793          	addi	a5,s6,8
 65a:	f8f43423          	sd	a5,-120(s0)
 65e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 662:	03000593          	li	a1,48
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	e2e080e7          	jalr	-466(ra) # 496 <putc>
  putc(fd, 'x');
 670:	07800593          	li	a1,120
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e20080e7          	jalr	-480(ra) # 496 <putc>
 67e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 680:	03c9d793          	srli	a5,s3,0x3c
 684:	97de                	add	a5,a5,s7
 686:	0007c583          	lbu	a1,0(a5)
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	e0a080e7          	jalr	-502(ra) # 496 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 694:	0992                	slli	s3,s3,0x4
 696:	397d                	addiw	s2,s2,-1
 698:	fe0914e3          	bnez	s2,680 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 69c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b70d                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 6a4:	008b0913          	addi	s2,s6,8
 6a8:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6ac:	02098163          	beqz	s3,6ce <vprintf+0x16a>
        while(*s != 0){
 6b0:	0009c583          	lbu	a1,0(s3)
 6b4:	c5ad                	beqz	a1,71e <vprintf+0x1ba>
          putc(fd, *s);
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	dde080e7          	jalr	-546(ra) # 496 <putc>
          s++;
 6c0:	0985                	addi	s3,s3,1
        while(*s != 0){
 6c2:	0009c583          	lbu	a1,0(s3)
 6c6:	f9e5                	bnez	a1,6b6 <vprintf+0x152>
        s = va_arg(ap, char*);
 6c8:	8b4a                	mv	s6,s2
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bde5                	j	5c4 <vprintf+0x60>
          s = "(null)";
 6ce:	00000997          	auipc	s3,0x0
 6d2:	2ba98993          	addi	s3,s3,698 # 988 <malloc+0x160>
        while(*s != 0){
 6d6:	85ee                	mv	a1,s11
 6d8:	bff9                	j	6b6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6da:	008b0913          	addi	s2,s6,8
 6de:	000b4583          	lbu	a1,0(s6)
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	db2080e7          	jalr	-590(ra) # 496 <putc>
 6ec:	8b4a                	mv	s6,s2
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	bdd1                	j	5c4 <vprintf+0x60>
        putc(fd, c);
 6f2:	85d2                	mv	a1,s4
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	da0080e7          	jalr	-608(ra) # 496 <putc>
      state = 0;
 6fe:	4981                	li	s3,0
 700:	b5d1                	j	5c4 <vprintf+0x60>
        putc(fd, '%');
 702:	85d2                	mv	a1,s4
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	d90080e7          	jalr	-624(ra) # 496 <putc>
        putc(fd, c);
 70e:	85ca                	mv	a1,s2
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	d84080e7          	jalr	-636(ra) # 496 <putc>
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b565                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 71e:	8b4a                	mv	s6,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	b54d                	j	5c4 <vprintf+0x60>
    }
  }
}
 724:	70e6                	ld	ra,120(sp)
 726:	7446                	ld	s0,112(sp)
 728:	74a6                	ld	s1,104(sp)
 72a:	7906                	ld	s2,96(sp)
 72c:	69e6                	ld	s3,88(sp)
 72e:	6a46                	ld	s4,80(sp)
 730:	6aa6                	ld	s5,72(sp)
 732:	6b06                	ld	s6,64(sp)
 734:	7be2                	ld	s7,56(sp)
 736:	7c42                	ld	s8,48(sp)
 738:	7ca2                	ld	s9,40(sp)
 73a:	7d02                	ld	s10,32(sp)
 73c:	6de2                	ld	s11,24(sp)
 73e:	6109                	addi	sp,sp,128
 740:	8082                	ret

0000000000000742 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 742:	715d                	addi	sp,sp,-80
 744:	ec06                	sd	ra,24(sp)
 746:	e822                	sd	s0,16(sp)
 748:	1000                	addi	s0,sp,32
 74a:	e010                	sd	a2,0(s0)
 74c:	e414                	sd	a3,8(s0)
 74e:	e818                	sd	a4,16(s0)
 750:	ec1c                	sd	a5,24(s0)
 752:	03043023          	sd	a6,32(s0)
 756:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75e:	8622                	mv	a2,s0
 760:	00000097          	auipc	ra,0x0
 764:	e04080e7          	jalr	-508(ra) # 564 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6161                	addi	sp,sp,80
 76e:	8082                	ret

0000000000000770 <printf>:

void
printf(const char *fmt, ...)
{
 770:	711d                	addi	sp,sp,-96
 772:	ec06                	sd	ra,24(sp)
 774:	e822                	sd	s0,16(sp)
 776:	1000                	addi	s0,sp,32
 778:	e40c                	sd	a1,8(s0)
 77a:	e810                	sd	a2,16(s0)
 77c:	ec14                	sd	a3,24(s0)
 77e:	f018                	sd	a4,32(s0)
 780:	f41c                	sd	a5,40(s0)
 782:	03043823          	sd	a6,48(s0)
 786:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78a:	00840613          	addi	a2,s0,8
 78e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 792:	85aa                	mv	a1,a0
 794:	4505                	li	a0,1
 796:	00000097          	auipc	ra,0x0
 79a:	dce080e7          	jalr	-562(ra) # 564 <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6125                	addi	sp,sp,96
 7a4:	8082                	ret

00000000000007a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	1141                	addi	sp,sp,-16
 7a8:	e422                	sd	s0,8(sp)
 7aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	00000797          	auipc	a5,0x0
 7b4:	2607b783          	ld	a5,608(a5) # a10 <freep>
 7b8:	a02d                	j	7e2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ba:	4618                	lw	a4,8(a2)
 7bc:	9f2d                	addw	a4,a4,a1
 7be:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c2:	6398                	ld	a4,0(a5)
 7c4:	6310                	ld	a2,0(a4)
 7c6:	a83d                	j	804 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c8:	ff852703          	lw	a4,-8(a0)
 7cc:	9f31                	addw	a4,a4,a2
 7ce:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d0:	ff053683          	ld	a3,-16(a0)
 7d4:	a091                	j	818 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d6:	6398                	ld	a4,0(a5)
 7d8:	00e7e463          	bltu	a5,a4,7e0 <free+0x3a>
 7dc:	00e6ea63          	bltu	a3,a4,7f0 <free+0x4a>
{
 7e0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e2:	fed7fae3          	bgeu	a5,a3,7d6 <free+0x30>
 7e6:	6398                	ld	a4,0(a5)
 7e8:	00e6e463          	bltu	a3,a4,7f0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ec:	fee7eae3          	bltu	a5,a4,7e0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7f0:	ff852583          	lw	a1,-8(a0)
 7f4:	6390                	ld	a2,0(a5)
 7f6:	02059813          	slli	a6,a1,0x20
 7fa:	01c85713          	srli	a4,a6,0x1c
 7fe:	9736                	add	a4,a4,a3
 800:	fae60de3          	beq	a2,a4,7ba <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 804:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 808:	4790                	lw	a2,8(a5)
 80a:	02061593          	slli	a1,a2,0x20
 80e:	01c5d713          	srli	a4,a1,0x1c
 812:	973e                	add	a4,a4,a5
 814:	fae68ae3          	beq	a3,a4,7c8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 818:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81a:	00000717          	auipc	a4,0x0
 81e:	1ef73b23          	sd	a5,502(a4) # a10 <freep>
}
 822:	6422                	ld	s0,8(sp)
 824:	0141                	addi	sp,sp,16
 826:	8082                	ret

0000000000000828 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 828:	7139                	addi	sp,sp,-64
 82a:	fc06                	sd	ra,56(sp)
 82c:	f822                	sd	s0,48(sp)
 82e:	f426                	sd	s1,40(sp)
 830:	f04a                	sd	s2,32(sp)
 832:	ec4e                	sd	s3,24(sp)
 834:	e852                	sd	s4,16(sp)
 836:	e456                	sd	s5,8(sp)
 838:	e05a                	sd	s6,0(sp)
 83a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83c:	02051493          	slli	s1,a0,0x20
 840:	9081                	srli	s1,s1,0x20
 842:	04bd                	addi	s1,s1,15
 844:	8091                	srli	s1,s1,0x4
 846:	0014899b          	addiw	s3,s1,1
 84a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 84c:	00000517          	auipc	a0,0x0
 850:	1c453503          	ld	a0,452(a0) # a10 <freep>
 854:	c515                	beqz	a0,880 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 856:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 858:	4798                	lw	a4,8(a5)
 85a:	02977f63          	bgeu	a4,s1,898 <malloc+0x70>
 85e:	8a4e                	mv	s4,s3
 860:	0009871b          	sext.w	a4,s3
 864:	6685                	lui	a3,0x1
 866:	00d77363          	bgeu	a4,a3,86c <malloc+0x44>
 86a:	6a05                	lui	s4,0x1
 86c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 870:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 874:	00000917          	auipc	s2,0x0
 878:	19c90913          	addi	s2,s2,412 # a10 <freep>
  if(p == (char*)-1)
 87c:	5afd                	li	s5,-1
 87e:	a895                	j	8f2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 880:	00000797          	auipc	a5,0x0
 884:	19878793          	addi	a5,a5,408 # a18 <base>
 888:	00000717          	auipc	a4,0x0
 88c:	18f73423          	sd	a5,392(a4) # a10 <freep>
 890:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 892:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 896:	b7e1                	j	85e <malloc+0x36>
      if(p->s.size == nunits)
 898:	02e48c63          	beq	s1,a4,8d0 <malloc+0xa8>
        p->s.size -= nunits;
 89c:	4137073b          	subw	a4,a4,s3
 8a0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a2:	02071693          	slli	a3,a4,0x20
 8a6:	01c6d713          	srli	a4,a3,0x1c
 8aa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b0:	00000717          	auipc	a4,0x0
 8b4:	16a73023          	sd	a0,352(a4) # a10 <freep>
      return (void*)(p + 1);
 8b8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8bc:	70e2                	ld	ra,56(sp)
 8be:	7442                	ld	s0,48(sp)
 8c0:	74a2                	ld	s1,40(sp)
 8c2:	7902                	ld	s2,32(sp)
 8c4:	69e2                	ld	s3,24(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	6121                	addi	sp,sp,64
 8ce:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d0:	6398                	ld	a4,0(a5)
 8d2:	e118                	sd	a4,0(a0)
 8d4:	bff1                	j	8b0 <malloc+0x88>
  hp->s.size = nu;
 8d6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8da:	0541                	addi	a0,a0,16
 8dc:	00000097          	auipc	ra,0x0
 8e0:	eca080e7          	jalr	-310(ra) # 7a6 <free>
  return freep;
 8e4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8e8:	d971                	beqz	a0,8bc <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ec:	4798                	lw	a4,8(a5)
 8ee:	fa9775e3          	bgeu	a4,s1,898 <malloc+0x70>
    if(p == freep)
 8f2:	00093703          	ld	a4,0(s2)
 8f6:	853e                	mv	a0,a5
 8f8:	fef719e3          	bne	a4,a5,8ea <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8fc:	8552                	mv	a0,s4
 8fe:	00000097          	auipc	ra,0x0
 902:	b80080e7          	jalr	-1152(ra) # 47e <sbrk>
  if(p == (char*)-1)
 906:	fd5518e3          	bne	a0,s5,8d6 <malloc+0xae>
        return 0;
 90a:	4501                	li	a0,0
 90c:	bf45                	j	8bc <malloc+0x94>
