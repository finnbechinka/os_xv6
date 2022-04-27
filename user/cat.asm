
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	9f090913          	addi	s2,s2,-1552 # a00 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	414080e7          	jalr	1044(ra) # 434 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	408080e7          	jalr	1032(ra) # 43c <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	8f858593          	addi	a1,a1,-1800 # 938 <malloc+0xea>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	71e080e7          	jalr	1822(ra) # 768 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	3c8080e7          	jalr	968(ra) # 41c <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	8e258593          	addi	a1,a1,-1822 # 950 <malloc+0x102>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	6f0080e7          	jalr	1776(ra) # 768 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	39a080e7          	jalr	922(ra) # 41c <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	e052                	sd	s4,0(sp)
  98:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9a:	4785                	li	a5,1
  9c:	04a7d763          	bge	a5,a0,ea <main+0x60>
  a0:	00858913          	addi	s2,a1,8
  a4:	ffe5099b          	addiw	s3,a0,-2
  a8:	02099793          	slli	a5,s3,0x20
  ac:	01d7d993          	srli	s3,a5,0x1d
  b0:	05c1                	addi	a1,a1,16
  b2:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b4:	4581                	li	a1,0
  b6:	00093503          	ld	a0,0(s2)
  ba:	00000097          	auipc	ra,0x0
  be:	3a2080e7          	jalr	930(ra) # 45c <open>
  c2:	84aa                	mv	s1,a0
  c4:	02054d63          	bltz	a0,fe <main+0x74>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c8:	00000097          	auipc	ra,0x0
  cc:	f38080e7          	jalr	-200(ra) # 0 <cat>
    close(fd);
  d0:	8526                	mv	a0,s1
  d2:	00000097          	auipc	ra,0x0
  d6:	372080e7          	jalr	882(ra) # 444 <close>
  for(i = 1; i < argc; i++){
  da:	0921                	addi	s2,s2,8
  dc:	fd391ce3          	bne	s2,s3,b4 <main+0x2a>
  }
  exit(0);
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	33a080e7          	jalr	826(ra) # 41c <exit>
    cat(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	f14080e7          	jalr	-236(ra) # 0 <cat>
    exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	326080e7          	jalr	806(ra) # 41c <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fe:	00093603          	ld	a2,0(s2)
 102:	00001597          	auipc	a1,0x1
 106:	86658593          	addi	a1,a1,-1946 # 968 <malloc+0x11a>
 10a:	4509                	li	a0,2
 10c:	00000097          	auipc	ra,0x0
 110:	65c080e7          	jalr	1628(ra) # 768 <fprintf>
      exit(1);
 114:	4505                	li	a0,1
 116:	00000097          	auipc	ra,0x0
 11a:	306080e7          	jalr	774(ra) # 41c <exit>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0x8>
    ;
  return os;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	cb91                	beqz	a5,158 <strcmp+0x1e>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	00f71763          	bne	a4,a5,158 <strcmp+0x1e>
    p++, q++;
 14e:	0505                	addi	a0,a0,1
 150:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 152:	00054783          	lbu	a5,0(a0)
 156:	fbe5                	bnez	a5,146 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 158:	0005c503          	lbu	a0,0(a1)
}
 15c:	40a7853b          	subw	a0,a5,a0
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf91                	beqz	a5,18c <strlen+0x26>
 172:	0505                	addi	a0,a0,1
 174:	87aa                	mv	a5,a0
 176:	4685                	li	a3,1
 178:	9e89                	subw	a3,a3,a0
 17a:	00f6853b          	addw	a0,a3,a5
 17e:	0785                	addi	a5,a5,1
 180:	fff7c703          	lbu	a4,-1(a5)
 184:	fb7d                	bnez	a4,17a <strlen+0x14>
    ;
  return n;
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	addi	sp,sp,16
 18a:	8082                	ret
  for(n = 0; s[n]; n++)
 18c:	4501                	li	a0,0
 18e:	bfe5                	j	186 <strlen+0x20>

0000000000000190 <strsub>:
int strsub(const char *s, const char *sub){
 190:	7139                	addi	sp,sp,-64
 192:	fc06                	sd	ra,56(sp)
 194:	f822                	sd	s0,48(sp)
 196:	f426                	sd	s1,40(sp)
 198:	f04a                	sd	s2,32(sp)
 19a:	ec4e                	sd	s3,24(sp)
 19c:	e852                	sd	s4,16(sp)
 19e:	e456                	sd	s5,8(sp)
 1a0:	0080                	addi	s0,sp,64
 1a2:	8a2a                	mv	s4,a0
 1a4:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 1a6:	84aa                	mv	s1,a0
 1a8:	4901                	li	s2,0
 1aa:	a019                	j	1b0 <strsub+0x20>
 1ac:	2905                	addiw	s2,s2,1
 1ae:	0485                	addi	s1,s1,1
 1b0:	8552                	mv	a0,s4
 1b2:	00000097          	auipc	ra,0x0
 1b6:	fb4080e7          	jalr	-76(ra) # 166 <strlen>
 1ba:	2501                	sext.w	a0,a0
 1bc:	04a97863          	bgeu	s2,a0,20c <strsub+0x7c>
    if(s[i] == sub[0]){
 1c0:	8aa6                	mv	s5,s1
 1c2:	0004c703          	lbu	a4,0(s1)
 1c6:	0009c783          	lbu	a5,0(s3)
 1ca:	fef711e3          	bne	a4,a5,1ac <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 1ce:	854e                	mv	a0,s3
 1d0:	00000097          	auipc	ra,0x0
 1d4:	f96080e7          	jalr	-106(ra) # 166 <strlen>
 1d8:	0005059b          	sext.w	a1,a0
 1dc:	ffe5061b          	addiw	a2,a0,-2
 1e0:	1602                	slli	a2,a2,0x20
 1e2:	9201                	srli	a2,a2,0x20
 1e4:	0609                	addi	a2,a2,2
 1e6:	4785                	li	a5,1
 1e8:	0007871b          	sext.w	a4,a5
 1ec:	fcb770e3          	bgeu	a4,a1,1ac <strsub+0x1c>
        if(s[j+i] != sub[j]){
 1f0:	00fa86b3          	add	a3,s5,a5
 1f4:	00f98733          	add	a4,s3,a5
 1f8:	0006c683          	lbu	a3,0(a3)
 1fc:	00074703          	lbu	a4,0(a4)
 200:	fae696e3          	bne	a3,a4,1ac <strsub+0x1c>
        if(j == strlen(sub) -1){
 204:	0785                	addi	a5,a5,1
 206:	fec791e3          	bne	a5,a2,1e8 <strsub+0x58>
 20a:	a011                	j	20e <strsub+0x7e>
  return -1;
 20c:	597d                	li	s2,-1
}
 20e:	854a                	mv	a0,s2
 210:	70e2                	ld	ra,56(sp)
 212:	7442                	ld	s0,48(sp)
 214:	74a2                	ld	s1,40(sp)
 216:	7902                	ld	s2,32(sp)
 218:	69e2                	ld	s3,24(sp)
 21a:	6a42                	ld	s4,16(sp)
 21c:	6aa2                	ld	s5,8(sp)
 21e:	6121                	addi	sp,sp,64
 220:	8082                	ret

0000000000000222 <memset>:

void*
memset(void *dst, int c, uint n)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 228:	ca19                	beqz	a2,23e <memset+0x1c>
 22a:	87aa                	mv	a5,a0
 22c:	1602                	slli	a2,a2,0x20
 22e:	9201                	srli	a2,a2,0x20
 230:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 234:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 238:	0785                	addi	a5,a5,1
 23a:	fee79de3          	bne	a5,a4,234 <memset+0x12>
  }
  return dst;
}
 23e:	6422                	ld	s0,8(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret

0000000000000244 <strchr>:

char*
strchr(const char *s, char c)
{
 244:	1141                	addi	sp,sp,-16
 246:	e422                	sd	s0,8(sp)
 248:	0800                	addi	s0,sp,16
  for(; *s; s++)
 24a:	00054783          	lbu	a5,0(a0)
 24e:	cb99                	beqz	a5,264 <strchr+0x20>
    if(*s == c)
 250:	00f58763          	beq	a1,a5,25e <strchr+0x1a>
  for(; *s; s++)
 254:	0505                	addi	a0,a0,1
 256:	00054783          	lbu	a5,0(a0)
 25a:	fbfd                	bnez	a5,250 <strchr+0xc>
      return (char*)s;
  return 0;
 25c:	4501                	li	a0,0
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
  return 0;
 264:	4501                	li	a0,0
 266:	bfe5                	j	25e <strchr+0x1a>

0000000000000268 <gets>:

char*
gets(char *buf, int max)
{
 268:	711d                	addi	sp,sp,-96
 26a:	ec86                	sd	ra,88(sp)
 26c:	e8a2                	sd	s0,80(sp)
 26e:	e4a6                	sd	s1,72(sp)
 270:	e0ca                	sd	s2,64(sp)
 272:	fc4e                	sd	s3,56(sp)
 274:	f852                	sd	s4,48(sp)
 276:	f456                	sd	s5,40(sp)
 278:	f05a                	sd	s6,32(sp)
 27a:	ec5e                	sd	s7,24(sp)
 27c:	1080                	addi	s0,sp,96
 27e:	8baa                	mv	s7,a0
 280:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 282:	892a                	mv	s2,a0
 284:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 286:	4aa9                	li	s5,10
 288:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 28a:	89a6                	mv	s3,s1
 28c:	2485                	addiw	s1,s1,1
 28e:	0344d863          	bge	s1,s4,2be <gets+0x56>
    cc = read(0, &c, 1);
 292:	4605                	li	a2,1
 294:	faf40593          	addi	a1,s0,-81
 298:	4501                	li	a0,0
 29a:	00000097          	auipc	ra,0x0
 29e:	19a080e7          	jalr	410(ra) # 434 <read>
    if(cc < 1)
 2a2:	00a05e63          	blez	a0,2be <gets+0x56>
    buf[i++] = c;
 2a6:	faf44783          	lbu	a5,-81(s0)
 2aa:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ae:	01578763          	beq	a5,s5,2bc <gets+0x54>
 2b2:	0905                	addi	s2,s2,1
 2b4:	fd679be3          	bne	a5,s6,28a <gets+0x22>
  for(i=0; i+1 < max; ){
 2b8:	89a6                	mv	s3,s1
 2ba:	a011                	j	2be <gets+0x56>
 2bc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2be:	99de                	add	s3,s3,s7
 2c0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2c4:	855e                	mv	a0,s7
 2c6:	60e6                	ld	ra,88(sp)
 2c8:	6446                	ld	s0,80(sp)
 2ca:	64a6                	ld	s1,72(sp)
 2cc:	6906                	ld	s2,64(sp)
 2ce:	79e2                	ld	s3,56(sp)
 2d0:	7a42                	ld	s4,48(sp)
 2d2:	7aa2                	ld	s5,40(sp)
 2d4:	7b02                	ld	s6,32(sp)
 2d6:	6be2                	ld	s7,24(sp)
 2d8:	6125                	addi	sp,sp,96
 2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
 2dc:	1101                	addi	sp,sp,-32
 2de:	ec06                	sd	ra,24(sp)
 2e0:	e822                	sd	s0,16(sp)
 2e2:	e426                	sd	s1,8(sp)
 2e4:	e04a                	sd	s2,0(sp)
 2e6:	1000                	addi	s0,sp,32
 2e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ea:	4581                	li	a1,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	170080e7          	jalr	368(ra) # 45c <open>
  if(fd < 0)
 2f4:	02054563          	bltz	a0,31e <stat+0x42>
 2f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2fa:	85ca                	mv	a1,s2
 2fc:	00000097          	auipc	ra,0x0
 300:	178080e7          	jalr	376(ra) # 474 <fstat>
 304:	892a                	mv	s2,a0
  close(fd);
 306:	8526                	mv	a0,s1
 308:	00000097          	auipc	ra,0x0
 30c:	13c080e7          	jalr	316(ra) # 444 <close>
  return r;
}
 310:	854a                	mv	a0,s2
 312:	60e2                	ld	ra,24(sp)
 314:	6442                	ld	s0,16(sp)
 316:	64a2                	ld	s1,8(sp)
 318:	6902                	ld	s2,0(sp)
 31a:	6105                	addi	sp,sp,32
 31c:	8082                	ret
    return -1;
 31e:	597d                	li	s2,-1
 320:	bfc5                	j	310 <stat+0x34>

0000000000000322 <atoi>:

int
atoi(const char *s)
{
 322:	1141                	addi	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 328:	00054683          	lbu	a3,0(a0)
 32c:	fd06879b          	addiw	a5,a3,-48
 330:	0ff7f793          	zext.b	a5,a5
 334:	4625                	li	a2,9
 336:	02f66863          	bltu	a2,a5,366 <atoi+0x44>
 33a:	872a                	mv	a4,a0
  n = 0;
 33c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 33e:	0705                	addi	a4,a4,1
 340:	0025179b          	slliw	a5,a0,0x2
 344:	9fa9                	addw	a5,a5,a0
 346:	0017979b          	slliw	a5,a5,0x1
 34a:	9fb5                	addw	a5,a5,a3
 34c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 350:	00074683          	lbu	a3,0(a4)
 354:	fd06879b          	addiw	a5,a3,-48
 358:	0ff7f793          	zext.b	a5,a5
 35c:	fef671e3          	bgeu	a2,a5,33e <atoi+0x1c>
  return n;
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
  n = 0;
 366:	4501                	li	a0,0
 368:	bfe5                	j	360 <atoi+0x3e>

000000000000036a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 370:	02b57463          	bgeu	a0,a1,398 <memmove+0x2e>
    while(n-- > 0)
 374:	00c05f63          	blez	a2,392 <memmove+0x28>
 378:	1602                	slli	a2,a2,0x20
 37a:	9201                	srli	a2,a2,0x20
 37c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 380:	872a                	mv	a4,a0
      *dst++ = *src++;
 382:	0585                	addi	a1,a1,1
 384:	0705                	addi	a4,a4,1
 386:	fff5c683          	lbu	a3,-1(a1)
 38a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 38e:	fee79ae3          	bne	a5,a4,382 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 392:	6422                	ld	s0,8(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret
    dst += n;
 398:	00c50733          	add	a4,a0,a2
    src += n;
 39c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 39e:	fec05ae3          	blez	a2,392 <memmove+0x28>
 3a2:	fff6079b          	addiw	a5,a2,-1
 3a6:	1782                	slli	a5,a5,0x20
 3a8:	9381                	srli	a5,a5,0x20
 3aa:	fff7c793          	not	a5,a5
 3ae:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b0:	15fd                	addi	a1,a1,-1
 3b2:	177d                	addi	a4,a4,-1
 3b4:	0005c683          	lbu	a3,0(a1)
 3b8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3bc:	fee79ae3          	bne	a5,a4,3b0 <memmove+0x46>
 3c0:	bfc9                	j	392 <memmove+0x28>

00000000000003c2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c2:	1141                	addi	sp,sp,-16
 3c4:	e422                	sd	s0,8(sp)
 3c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c8:	ca05                	beqz	a2,3f8 <memcmp+0x36>
 3ca:	fff6069b          	addiw	a3,a2,-1
 3ce:	1682                	slli	a3,a3,0x20
 3d0:	9281                	srli	a3,a3,0x20
 3d2:	0685                	addi	a3,a3,1
 3d4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d6:	00054783          	lbu	a5,0(a0)
 3da:	0005c703          	lbu	a4,0(a1)
 3de:	00e79863          	bne	a5,a4,3ee <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3e2:	0505                	addi	a0,a0,1
    p2++;
 3e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e6:	fed518e3          	bne	a0,a3,3d6 <memcmp+0x14>
  }
  return 0;
 3ea:	4501                	li	a0,0
 3ec:	a019                	j	3f2 <memcmp+0x30>
      return *p1 - *p2;
 3ee:	40e7853b          	subw	a0,a5,a4
}
 3f2:	6422                	ld	s0,8(sp)
 3f4:	0141                	addi	sp,sp,16
 3f6:	8082                	ret
  return 0;
 3f8:	4501                	li	a0,0
 3fa:	bfe5                	j	3f2 <memcmp+0x30>

00000000000003fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e406                	sd	ra,8(sp)
 400:	e022                	sd	s0,0(sp)
 402:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 404:	00000097          	auipc	ra,0x0
 408:	f66080e7          	jalr	-154(ra) # 36a <memmove>
}
 40c:	60a2                	ld	ra,8(sp)
 40e:	6402                	ld	s0,0(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret

0000000000000414 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 414:	4885                	li	a7,1
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <exit>:
.global exit
exit:
 li a7, SYS_exit
 41c:	4889                	li	a7,2
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <wait>:
.global wait
wait:
 li a7, SYS_wait
 424:	488d                	li	a7,3
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 42c:	4891                	li	a7,4
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <read>:
.global read
read:
 li a7, SYS_read
 434:	4895                	li	a7,5
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <write>:
.global write
write:
 li a7, SYS_write
 43c:	48c1                	li	a7,16
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <close>:
.global close
close:
 li a7, SYS_close
 444:	48d5                	li	a7,21
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <kill>:
.global kill
kill:
 li a7, SYS_kill
 44c:	4899                	li	a7,6
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <exec>:
.global exec
exec:
 li a7, SYS_exec
 454:	489d                	li	a7,7
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <open>:
.global open
open:
 li a7, SYS_open
 45c:	48bd                	li	a7,15
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 464:	48c5                	li	a7,17
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 46c:	48c9                	li	a7,18
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 474:	48a1                	li	a7,8
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <link>:
.global link
link:
 li a7, SYS_link
 47c:	48cd                	li	a7,19
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 484:	48d1                	li	a7,20
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 48c:	48a5                	li	a7,9
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <dup>:
.global dup
dup:
 li a7, SYS_dup
 494:	48a9                	li	a7,10
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 49c:	48ad                	li	a7,11
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4a4:	48b1                	li	a7,12
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ac:	48b5                	li	a7,13
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b4:	48b9                	li	a7,14
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4bc:	1101                	addi	sp,sp,-32
 4be:	ec06                	sd	ra,24(sp)
 4c0:	e822                	sd	s0,16(sp)
 4c2:	1000                	addi	s0,sp,32
 4c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c8:	4605                	li	a2,1
 4ca:	fef40593          	addi	a1,s0,-17
 4ce:	00000097          	auipc	ra,0x0
 4d2:	f6e080e7          	jalr	-146(ra) # 43c <write>
}
 4d6:	60e2                	ld	ra,24(sp)
 4d8:	6442                	ld	s0,16(sp)
 4da:	6105                	addi	sp,sp,32
 4dc:	8082                	ret

00000000000004de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4de:	7139                	addi	sp,sp,-64
 4e0:	fc06                	sd	ra,56(sp)
 4e2:	f822                	sd	s0,48(sp)
 4e4:	f426                	sd	s1,40(sp)
 4e6:	f04a                	sd	s2,32(sp)
 4e8:	ec4e                	sd	s3,24(sp)
 4ea:	0080                	addi	s0,sp,64
 4ec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ee:	c299                	beqz	a3,4f4 <printint+0x16>
 4f0:	0805c963          	bltz	a1,582 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f4:	2581                	sext.w	a1,a1
  neg = 0;
 4f6:	4881                	li	a7,0
 4f8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4fc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4fe:	2601                	sext.w	a2,a2
 500:	00000517          	auipc	a0,0x0
 504:	4e050513          	addi	a0,a0,1248 # 9e0 <digits>
 508:	883a                	mv	a6,a4
 50a:	2705                	addiw	a4,a4,1
 50c:	02c5f7bb          	remuw	a5,a1,a2
 510:	1782                	slli	a5,a5,0x20
 512:	9381                	srli	a5,a5,0x20
 514:	97aa                	add	a5,a5,a0
 516:	0007c783          	lbu	a5,0(a5)
 51a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 51e:	0005879b          	sext.w	a5,a1
 522:	02c5d5bb          	divuw	a1,a1,a2
 526:	0685                	addi	a3,a3,1
 528:	fec7f0e3          	bgeu	a5,a2,508 <printint+0x2a>
  if(neg)
 52c:	00088c63          	beqz	a7,544 <printint+0x66>
    buf[i++] = '-';
 530:	fd070793          	addi	a5,a4,-48
 534:	00878733          	add	a4,a5,s0
 538:	02d00793          	li	a5,45
 53c:	fef70823          	sb	a5,-16(a4)
 540:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 544:	02e05863          	blez	a4,574 <printint+0x96>
 548:	fc040793          	addi	a5,s0,-64
 54c:	00e78933          	add	s2,a5,a4
 550:	fff78993          	addi	s3,a5,-1
 554:	99ba                	add	s3,s3,a4
 556:	377d                	addiw	a4,a4,-1
 558:	1702                	slli	a4,a4,0x20
 55a:	9301                	srli	a4,a4,0x20
 55c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 560:	fff94583          	lbu	a1,-1(s2)
 564:	8526                	mv	a0,s1
 566:	00000097          	auipc	ra,0x0
 56a:	f56080e7          	jalr	-170(ra) # 4bc <putc>
  while(--i >= 0)
 56e:	197d                	addi	s2,s2,-1
 570:	ff3918e3          	bne	s2,s3,560 <printint+0x82>
}
 574:	70e2                	ld	ra,56(sp)
 576:	7442                	ld	s0,48(sp)
 578:	74a2                	ld	s1,40(sp)
 57a:	7902                	ld	s2,32(sp)
 57c:	69e2                	ld	s3,24(sp)
 57e:	6121                	addi	sp,sp,64
 580:	8082                	ret
    x = -xx;
 582:	40b005bb          	negw	a1,a1
    neg = 1;
 586:	4885                	li	a7,1
    x = -xx;
 588:	bf85                	j	4f8 <printint+0x1a>

000000000000058a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58a:	7119                	addi	sp,sp,-128
 58c:	fc86                	sd	ra,120(sp)
 58e:	f8a2                	sd	s0,112(sp)
 590:	f4a6                	sd	s1,104(sp)
 592:	f0ca                	sd	s2,96(sp)
 594:	ecce                	sd	s3,88(sp)
 596:	e8d2                	sd	s4,80(sp)
 598:	e4d6                	sd	s5,72(sp)
 59a:	e0da                	sd	s6,64(sp)
 59c:	fc5e                	sd	s7,56(sp)
 59e:	f862                	sd	s8,48(sp)
 5a0:	f466                	sd	s9,40(sp)
 5a2:	f06a                	sd	s10,32(sp)
 5a4:	ec6e                	sd	s11,24(sp)
 5a6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a8:	0005c903          	lbu	s2,0(a1)
 5ac:	18090f63          	beqz	s2,74a <vprintf+0x1c0>
 5b0:	8aaa                	mv	s5,a0
 5b2:	8b32                	mv	s6,a2
 5b4:	00158493          	addi	s1,a1,1
  state = 0;
 5b8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ba:	02500a13          	li	s4,37
 5be:	4c55                	li	s8,21
 5c0:	00000c97          	auipc	s9,0x0
 5c4:	3c8c8c93          	addi	s9,s9,968 # 988 <malloc+0x13a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c8:	02800d93          	li	s11,40
  putc(fd, 'x');
 5cc:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ce:	00000b97          	auipc	s7,0x0
 5d2:	412b8b93          	addi	s7,s7,1042 # 9e0 <digits>
 5d6:	a839                	j	5f4 <vprintf+0x6a>
        putc(fd, c);
 5d8:	85ca                	mv	a1,s2
 5da:	8556                	mv	a0,s5
 5dc:	00000097          	auipc	ra,0x0
 5e0:	ee0080e7          	jalr	-288(ra) # 4bc <putc>
 5e4:	a019                	j	5ea <vprintf+0x60>
    } else if(state == '%'){
 5e6:	01498d63          	beq	s3,s4,600 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5ea:	0485                	addi	s1,s1,1
 5ec:	fff4c903          	lbu	s2,-1(s1)
 5f0:	14090d63          	beqz	s2,74a <vprintf+0x1c0>
    if(state == 0){
 5f4:	fe0999e3          	bnez	s3,5e6 <vprintf+0x5c>
      if(c == '%'){
 5f8:	ff4910e3          	bne	s2,s4,5d8 <vprintf+0x4e>
        state = '%';
 5fc:	89d2                	mv	s3,s4
 5fe:	b7f5                	j	5ea <vprintf+0x60>
      if(c == 'd'){
 600:	11490c63          	beq	s2,s4,718 <vprintf+0x18e>
 604:	f9d9079b          	addiw	a5,s2,-99
 608:	0ff7f793          	zext.b	a5,a5
 60c:	10fc6e63          	bltu	s8,a5,728 <vprintf+0x19e>
 610:	f9d9079b          	addiw	a5,s2,-99
 614:	0ff7f713          	zext.b	a4,a5
 618:	10ec6863          	bltu	s8,a4,728 <vprintf+0x19e>
 61c:	00271793          	slli	a5,a4,0x2
 620:	97e6                	add	a5,a5,s9
 622:	439c                	lw	a5,0(a5)
 624:	97e6                	add	a5,a5,s9
 626:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 628:	008b0913          	addi	s2,s6,8
 62c:	4685                	li	a3,1
 62e:	4629                	li	a2,10
 630:	000b2583          	lw	a1,0(s6)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	ea8080e7          	jalr	-344(ra) # 4de <printint>
 63e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 640:	4981                	li	s3,0
 642:	b765                	j	5ea <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 644:	008b0913          	addi	s2,s6,8
 648:	4681                	li	a3,0
 64a:	4629                	li	a2,10
 64c:	000b2583          	lw	a1,0(s6)
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	e8c080e7          	jalr	-372(ra) # 4de <printint>
 65a:	8b4a                	mv	s6,s2
      state = 0;
 65c:	4981                	li	s3,0
 65e:	b771                	j	5ea <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 660:	008b0913          	addi	s2,s6,8
 664:	4681                	li	a3,0
 666:	866a                	mv	a2,s10
 668:	000b2583          	lw	a1,0(s6)
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e70080e7          	jalr	-400(ra) # 4de <printint>
 676:	8b4a                	mv	s6,s2
      state = 0;
 678:	4981                	li	s3,0
 67a:	bf85                	j	5ea <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 67c:	008b0793          	addi	a5,s6,8
 680:	f8f43423          	sd	a5,-120(s0)
 684:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 688:	03000593          	li	a1,48
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e2e080e7          	jalr	-466(ra) # 4bc <putc>
  putc(fd, 'x');
 696:	07800593          	li	a1,120
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	e20080e7          	jalr	-480(ra) # 4bc <putc>
 6a4:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a6:	03c9d793          	srli	a5,s3,0x3c
 6aa:	97de                	add	a5,a5,s7
 6ac:	0007c583          	lbu	a1,0(a5)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e0a080e7          	jalr	-502(ra) # 4bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ba:	0992                	slli	s3,s3,0x4
 6bc:	397d                	addiw	s2,s2,-1
 6be:	fe0914e3          	bnez	s2,6a6 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	b70d                	j	5ea <vprintf+0x60>
        s = va_arg(ap, char*);
 6ca:	008b0913          	addi	s2,s6,8
 6ce:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6d2:	02098163          	beqz	s3,6f4 <vprintf+0x16a>
        while(*s != 0){
 6d6:	0009c583          	lbu	a1,0(s3)
 6da:	c5ad                	beqz	a1,744 <vprintf+0x1ba>
          putc(fd, *s);
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	dde080e7          	jalr	-546(ra) # 4bc <putc>
          s++;
 6e6:	0985                	addi	s3,s3,1
        while(*s != 0){
 6e8:	0009c583          	lbu	a1,0(s3)
 6ec:	f9e5                	bnez	a1,6dc <vprintf+0x152>
        s = va_arg(ap, char*);
 6ee:	8b4a                	mv	s6,s2
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	bde5                	j	5ea <vprintf+0x60>
          s = "(null)";
 6f4:	00000997          	auipc	s3,0x0
 6f8:	28c98993          	addi	s3,s3,652 # 980 <malloc+0x132>
        while(*s != 0){
 6fc:	85ee                	mv	a1,s11
 6fe:	bff9                	j	6dc <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 700:	008b0913          	addi	s2,s6,8
 704:	000b4583          	lbu	a1,0(s6)
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	db2080e7          	jalr	-590(ra) # 4bc <putc>
 712:	8b4a                	mv	s6,s2
      state = 0;
 714:	4981                	li	s3,0
 716:	bdd1                	j	5ea <vprintf+0x60>
        putc(fd, c);
 718:	85d2                	mv	a1,s4
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	da0080e7          	jalr	-608(ra) # 4bc <putc>
      state = 0;
 724:	4981                	li	s3,0
 726:	b5d1                	j	5ea <vprintf+0x60>
        putc(fd, '%');
 728:	85d2                	mv	a1,s4
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	d90080e7          	jalr	-624(ra) # 4bc <putc>
        putc(fd, c);
 734:	85ca                	mv	a1,s2
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	d84080e7          	jalr	-636(ra) # 4bc <putc>
      state = 0;
 740:	4981                	li	s3,0
 742:	b565                	j	5ea <vprintf+0x60>
        s = va_arg(ap, char*);
 744:	8b4a                	mv	s6,s2
      state = 0;
 746:	4981                	li	s3,0
 748:	b54d                	j	5ea <vprintf+0x60>
    }
  }
}
 74a:	70e6                	ld	ra,120(sp)
 74c:	7446                	ld	s0,112(sp)
 74e:	74a6                	ld	s1,104(sp)
 750:	7906                	ld	s2,96(sp)
 752:	69e6                	ld	s3,88(sp)
 754:	6a46                	ld	s4,80(sp)
 756:	6aa6                	ld	s5,72(sp)
 758:	6b06                	ld	s6,64(sp)
 75a:	7be2                	ld	s7,56(sp)
 75c:	7c42                	ld	s8,48(sp)
 75e:	7ca2                	ld	s9,40(sp)
 760:	7d02                	ld	s10,32(sp)
 762:	6de2                	ld	s11,24(sp)
 764:	6109                	addi	sp,sp,128
 766:	8082                	ret

0000000000000768 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 768:	715d                	addi	sp,sp,-80
 76a:	ec06                	sd	ra,24(sp)
 76c:	e822                	sd	s0,16(sp)
 76e:	1000                	addi	s0,sp,32
 770:	e010                	sd	a2,0(s0)
 772:	e414                	sd	a3,8(s0)
 774:	e818                	sd	a4,16(s0)
 776:	ec1c                	sd	a5,24(s0)
 778:	03043023          	sd	a6,32(s0)
 77c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 780:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 784:	8622                	mv	a2,s0
 786:	00000097          	auipc	ra,0x0
 78a:	e04080e7          	jalr	-508(ra) # 58a <vprintf>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6161                	addi	sp,sp,80
 794:	8082                	ret

0000000000000796 <printf>:

void
printf(const char *fmt, ...)
{
 796:	711d                	addi	sp,sp,-96
 798:	ec06                	sd	ra,24(sp)
 79a:	e822                	sd	s0,16(sp)
 79c:	1000                	addi	s0,sp,32
 79e:	e40c                	sd	a1,8(s0)
 7a0:	e810                	sd	a2,16(s0)
 7a2:	ec14                	sd	a3,24(s0)
 7a4:	f018                	sd	a4,32(s0)
 7a6:	f41c                	sd	a5,40(s0)
 7a8:	03043823          	sd	a6,48(s0)
 7ac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b0:	00840613          	addi	a2,s0,8
 7b4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b8:	85aa                	mv	a1,a0
 7ba:	4505                	li	a0,1
 7bc:	00000097          	auipc	ra,0x0
 7c0:	dce080e7          	jalr	-562(ra) # 58a <vprintf>
}
 7c4:	60e2                	ld	ra,24(sp)
 7c6:	6442                	ld	s0,16(sp)
 7c8:	6125                	addi	sp,sp,96
 7ca:	8082                	ret

00000000000007cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7cc:	1141                	addi	sp,sp,-16
 7ce:	e422                	sd	s0,8(sp)
 7d0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d6:	00000797          	auipc	a5,0x0
 7da:	2227b783          	ld	a5,546(a5) # 9f8 <freep>
 7de:	a02d                	j	808 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e0:	4618                	lw	a4,8(a2)
 7e2:	9f2d                	addw	a4,a4,a1
 7e4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e8:	6398                	ld	a4,0(a5)
 7ea:	6310                	ld	a2,0(a4)
 7ec:	a83d                	j	82a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ee:	ff852703          	lw	a4,-8(a0)
 7f2:	9f31                	addw	a4,a4,a2
 7f4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f6:	ff053683          	ld	a3,-16(a0)
 7fa:	a091                	j	83e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	6398                	ld	a4,0(a5)
 7fe:	00e7e463          	bltu	a5,a4,806 <free+0x3a>
 802:	00e6ea63          	bltu	a3,a4,816 <free+0x4a>
{
 806:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	fed7fae3          	bgeu	a5,a3,7fc <free+0x30>
 80c:	6398                	ld	a4,0(a5)
 80e:	00e6e463          	bltu	a3,a4,816 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 812:	fee7eae3          	bltu	a5,a4,806 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 816:	ff852583          	lw	a1,-8(a0)
 81a:	6390                	ld	a2,0(a5)
 81c:	02059813          	slli	a6,a1,0x20
 820:	01c85713          	srli	a4,a6,0x1c
 824:	9736                	add	a4,a4,a3
 826:	fae60de3          	beq	a2,a4,7e0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 82a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82e:	4790                	lw	a2,8(a5)
 830:	02061593          	slli	a1,a2,0x20
 834:	01c5d713          	srli	a4,a1,0x1c
 838:	973e                	add	a4,a4,a5
 83a:	fae68ae3          	beq	a3,a4,7ee <free+0x22>
    p->s.ptr = bp->s.ptr;
 83e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 840:	00000717          	auipc	a4,0x0
 844:	1af73c23          	sd	a5,440(a4) # 9f8 <freep>
}
 848:	6422                	ld	s0,8(sp)
 84a:	0141                	addi	sp,sp,16
 84c:	8082                	ret

000000000000084e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84e:	7139                	addi	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f426                	sd	s1,40(sp)
 856:	f04a                	sd	s2,32(sp)
 858:	ec4e                	sd	s3,24(sp)
 85a:	e852                	sd	s4,16(sp)
 85c:	e456                	sd	s5,8(sp)
 85e:	e05a                	sd	s6,0(sp)
 860:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	02051493          	slli	s1,a0,0x20
 866:	9081                	srli	s1,s1,0x20
 868:	04bd                	addi	s1,s1,15
 86a:	8091                	srli	s1,s1,0x4
 86c:	0014899b          	addiw	s3,s1,1
 870:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 872:	00000517          	auipc	a0,0x0
 876:	18653503          	ld	a0,390(a0) # 9f8 <freep>
 87a:	c515                	beqz	a0,8a6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87e:	4798                	lw	a4,8(a5)
 880:	02977f63          	bgeu	a4,s1,8be <malloc+0x70>
 884:	8a4e                	mv	s4,s3
 886:	0009871b          	sext.w	a4,s3
 88a:	6685                	lui	a3,0x1
 88c:	00d77363          	bgeu	a4,a3,892 <malloc+0x44>
 890:	6a05                	lui	s4,0x1
 892:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 896:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 89a:	00000917          	auipc	s2,0x0
 89e:	15e90913          	addi	s2,s2,350 # 9f8 <freep>
  if(p == (char*)-1)
 8a2:	5afd                	li	s5,-1
 8a4:	a895                	j	918 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8a6:	00000797          	auipc	a5,0x0
 8aa:	35a78793          	addi	a5,a5,858 # c00 <base>
 8ae:	00000717          	auipc	a4,0x0
 8b2:	14f73523          	sd	a5,330(a4) # 9f8 <freep>
 8b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8bc:	b7e1                	j	884 <malloc+0x36>
      if(p->s.size == nunits)
 8be:	02e48c63          	beq	s1,a4,8f6 <malloc+0xa8>
        p->s.size -= nunits;
 8c2:	4137073b          	subw	a4,a4,s3
 8c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c8:	02071693          	slli	a3,a4,0x20
 8cc:	01c6d713          	srli	a4,a3,0x1c
 8d0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d6:	00000717          	auipc	a4,0x0
 8da:	12a73123          	sd	a0,290(a4) # 9f8 <freep>
      return (void*)(p + 1);
 8de:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e2:	70e2                	ld	ra,56(sp)
 8e4:	7442                	ld	s0,48(sp)
 8e6:	74a2                	ld	s1,40(sp)
 8e8:	7902                	ld	s2,32(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6a42                	ld	s4,16(sp)
 8ee:	6aa2                	ld	s5,8(sp)
 8f0:	6b02                	ld	s6,0(sp)
 8f2:	6121                	addi	sp,sp,64
 8f4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8f6:	6398                	ld	a4,0(a5)
 8f8:	e118                	sd	a4,0(a0)
 8fa:	bff1                	j	8d6 <malloc+0x88>
  hp->s.size = nu;
 8fc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 900:	0541                	addi	a0,a0,16
 902:	00000097          	auipc	ra,0x0
 906:	eca080e7          	jalr	-310(ra) # 7cc <free>
  return freep;
 90a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 90e:	d971                	beqz	a0,8e2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 912:	4798                	lw	a4,8(a5)
 914:	fa9775e3          	bgeu	a4,s1,8be <malloc+0x70>
    if(p == freep)
 918:	00093703          	ld	a4,0(s2)
 91c:	853e                	mv	a0,a5
 91e:	fef719e3          	bne	a4,a5,910 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	00000097          	auipc	ra,0x0
 928:	b80080e7          	jalr	-1152(ra) # 4a4 <sbrk>
  if(p == (char*)-1)
 92c:	fd5518e3          	bne	a0,s5,8fc <malloc+0xae>
        return 0;
 930:	4501                	li	a0,0
 932:	bf45                	j	8e2 <malloc+0x94>
