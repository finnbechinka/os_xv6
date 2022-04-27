
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	02099793          	slli	a5,s3,0x20
  22:	01d7d993          	srli	s3,a5,0x1d
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	876a0a13          	addi	s4,s4,-1930 # 8a0 <malloc+0xec>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	094080e7          	jalr	148(ra) # cc <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	35a080e7          	jalr	858(ra) # 3a2 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	346080e7          	jalr	838(ra) # 3a2 <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	84058593          	addi	a1,a1,-1984 # 8a8 <malloc+0xf4>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	330080e7          	jalr	816(ra) # 3a2 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	306080e7          	jalr	774(ra) # 382 <exit>

0000000000000084 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	87aa                	mv	a5,a0
  8c:	0585                	addi	a1,a1,1
  8e:	0785                	addi	a5,a5,1
  90:	fff5c703          	lbu	a4,-1(a1)
  94:	fee78fa3          	sb	a4,-1(a5)
  98:	fb75                	bnez	a4,8c <strcpy+0x8>
    ;
  return os;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	cb91                	beqz	a5,be <strcmp+0x1e>
  ac:	0005c703          	lbu	a4,0(a1)
  b0:	00f71763          	bne	a4,a5,be <strcmp+0x1e>
    p++, q++;
  b4:	0505                	addi	a0,a0,1
  b6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	fbe5                	bnez	a5,ac <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  be:	0005c503          	lbu	a0,0(a1)
}
  c2:	40a7853b          	subw	a0,a5,a0
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	cf91                	beqz	a5,f2 <strlen+0x26>
  d8:	0505                	addi	a0,a0,1
  da:	87aa                	mv	a5,a0
  dc:	4685                	li	a3,1
  de:	9e89                	subw	a3,a3,a0
  e0:	00f6853b          	addw	a0,a3,a5
  e4:	0785                	addi	a5,a5,1
  e6:	fff7c703          	lbu	a4,-1(a5)
  ea:	fb7d                	bnez	a4,e0 <strlen+0x14>
    ;
  return n;
}
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  for(n = 0; s[n]; n++)
  f2:	4501                	li	a0,0
  f4:	bfe5                	j	ec <strlen+0x20>

00000000000000f6 <strsub>:
int strsub(const char *s, const char *sub){
  f6:	7139                	addi	sp,sp,-64
  f8:	fc06                	sd	ra,56(sp)
  fa:	f822                	sd	s0,48(sp)
  fc:	f426                	sd	s1,40(sp)
  fe:	f04a                	sd	s2,32(sp)
 100:	ec4e                	sd	s3,24(sp)
 102:	e852                	sd	s4,16(sp)
 104:	e456                	sd	s5,8(sp)
 106:	0080                	addi	s0,sp,64
 108:	8a2a                	mv	s4,a0
 10a:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 10c:	84aa                	mv	s1,a0
 10e:	4901                	li	s2,0
 110:	a019                	j	116 <strsub+0x20>
 112:	2905                	addiw	s2,s2,1
 114:	0485                	addi	s1,s1,1
 116:	8552                	mv	a0,s4
 118:	00000097          	auipc	ra,0x0
 11c:	fb4080e7          	jalr	-76(ra) # cc <strlen>
 120:	2501                	sext.w	a0,a0
 122:	04a97863          	bgeu	s2,a0,172 <strsub+0x7c>
    if(s[i] == sub[0]){
 126:	8aa6                	mv	s5,s1
 128:	0004c703          	lbu	a4,0(s1)
 12c:	0009c783          	lbu	a5,0(s3)
 130:	fef711e3          	bne	a4,a5,112 <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 134:	854e                	mv	a0,s3
 136:	00000097          	auipc	ra,0x0
 13a:	f96080e7          	jalr	-106(ra) # cc <strlen>
 13e:	0005059b          	sext.w	a1,a0
 142:	ffe5061b          	addiw	a2,a0,-2
 146:	1602                	slli	a2,a2,0x20
 148:	9201                	srli	a2,a2,0x20
 14a:	0609                	addi	a2,a2,2
 14c:	4785                	li	a5,1
 14e:	0007871b          	sext.w	a4,a5
 152:	fcb770e3          	bgeu	a4,a1,112 <strsub+0x1c>
        if(s[j+i] != sub[j]){
 156:	00fa86b3          	add	a3,s5,a5
 15a:	00f98733          	add	a4,s3,a5
 15e:	0006c683          	lbu	a3,0(a3)
 162:	00074703          	lbu	a4,0(a4)
 166:	fae696e3          	bne	a3,a4,112 <strsub+0x1c>
        if(j == strlen(sub) -1){
 16a:	0785                	addi	a5,a5,1
 16c:	fec791e3          	bne	a5,a2,14e <strsub+0x58>
 170:	a011                	j	174 <strsub+0x7e>
  return -1;
 172:	597d                	li	s2,-1
}
 174:	854a                	mv	a0,s2
 176:	70e2                	ld	ra,56(sp)
 178:	7442                	ld	s0,48(sp)
 17a:	74a2                	ld	s1,40(sp)
 17c:	7902                	ld	s2,32(sp)
 17e:	69e2                	ld	s3,24(sp)
 180:	6a42                	ld	s4,16(sp)
 182:	6aa2                	ld	s5,8(sp)
 184:	6121                	addi	sp,sp,64
 186:	8082                	ret

0000000000000188 <memset>:

void*
memset(void *dst, int c, uint n)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18e:	ca19                	beqz	a2,1a4 <memset+0x1c>
 190:	87aa                	mv	a5,a0
 192:	1602                	slli	a2,a2,0x20
 194:	9201                	srli	a2,a2,0x20
 196:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 19a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19e:	0785                	addi	a5,a5,1
 1a0:	fee79de3          	bne	a5,a4,19a <memset+0x12>
  }
  return dst;
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret

00000000000001aa <strchr>:

char*
strchr(const char *s, char c)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b0:	00054783          	lbu	a5,0(a0)
 1b4:	cb99                	beqz	a5,1ca <strchr+0x20>
    if(*s == c)
 1b6:	00f58763          	beq	a1,a5,1c4 <strchr+0x1a>
  for(; *s; s++)
 1ba:	0505                	addi	a0,a0,1
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	fbfd                	bnez	a5,1b6 <strchr+0xc>
      return (char*)s;
  return 0;
 1c2:	4501                	li	a0,0
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret
  return 0;
 1ca:	4501                	li	a0,0
 1cc:	bfe5                	j	1c4 <strchr+0x1a>

00000000000001ce <gets>:

char*
gets(char *buf, int max)
{
 1ce:	711d                	addi	sp,sp,-96
 1d0:	ec86                	sd	ra,88(sp)
 1d2:	e8a2                	sd	s0,80(sp)
 1d4:	e4a6                	sd	s1,72(sp)
 1d6:	e0ca                	sd	s2,64(sp)
 1d8:	fc4e                	sd	s3,56(sp)
 1da:	f852                	sd	s4,48(sp)
 1dc:	f456                	sd	s5,40(sp)
 1de:	f05a                	sd	s6,32(sp)
 1e0:	ec5e                	sd	s7,24(sp)
 1e2:	1080                	addi	s0,sp,96
 1e4:	8baa                	mv	s7,a0
 1e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e8:	892a                	mv	s2,a0
 1ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ec:	4aa9                	li	s5,10
 1ee:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1f0:	89a6                	mv	s3,s1
 1f2:	2485                	addiw	s1,s1,1
 1f4:	0344d863          	bge	s1,s4,224 <gets+0x56>
    cc = read(0, &c, 1);
 1f8:	4605                	li	a2,1
 1fa:	faf40593          	addi	a1,s0,-81
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	19a080e7          	jalr	410(ra) # 39a <read>
    if(cc < 1)
 208:	00a05e63          	blez	a0,224 <gets+0x56>
    buf[i++] = c;
 20c:	faf44783          	lbu	a5,-81(s0)
 210:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 214:	01578763          	beq	a5,s5,222 <gets+0x54>
 218:	0905                	addi	s2,s2,1
 21a:	fd679be3          	bne	a5,s6,1f0 <gets+0x22>
  for(i=0; i+1 < max; ){
 21e:	89a6                	mv	s3,s1
 220:	a011                	j	224 <gets+0x56>
 222:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 224:	99de                	add	s3,s3,s7
 226:	00098023          	sb	zero,0(s3)
  return buf;
}
 22a:	855e                	mv	a0,s7
 22c:	60e6                	ld	ra,88(sp)
 22e:	6446                	ld	s0,80(sp)
 230:	64a6                	ld	s1,72(sp)
 232:	6906                	ld	s2,64(sp)
 234:	79e2                	ld	s3,56(sp)
 236:	7a42                	ld	s4,48(sp)
 238:	7aa2                	ld	s5,40(sp)
 23a:	7b02                	ld	s6,32(sp)
 23c:	6be2                	ld	s7,24(sp)
 23e:	6125                	addi	sp,sp,96
 240:	8082                	ret

0000000000000242 <stat>:

int
stat(const char *n, struct stat *st)
{
 242:	1101                	addi	sp,sp,-32
 244:	ec06                	sd	ra,24(sp)
 246:	e822                	sd	s0,16(sp)
 248:	e426                	sd	s1,8(sp)
 24a:	e04a                	sd	s2,0(sp)
 24c:	1000                	addi	s0,sp,32
 24e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 250:	4581                	li	a1,0
 252:	00000097          	auipc	ra,0x0
 256:	170080e7          	jalr	368(ra) # 3c2 <open>
  if(fd < 0)
 25a:	02054563          	bltz	a0,284 <stat+0x42>
 25e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 260:	85ca                	mv	a1,s2
 262:	00000097          	auipc	ra,0x0
 266:	178080e7          	jalr	376(ra) # 3da <fstat>
 26a:	892a                	mv	s2,a0
  close(fd);
 26c:	8526                	mv	a0,s1
 26e:	00000097          	auipc	ra,0x0
 272:	13c080e7          	jalr	316(ra) # 3aa <close>
  return r;
}
 276:	854a                	mv	a0,s2
 278:	60e2                	ld	ra,24(sp)
 27a:	6442                	ld	s0,16(sp)
 27c:	64a2                	ld	s1,8(sp)
 27e:	6902                	ld	s2,0(sp)
 280:	6105                	addi	sp,sp,32
 282:	8082                	ret
    return -1;
 284:	597d                	li	s2,-1
 286:	bfc5                	j	276 <stat+0x34>

0000000000000288 <atoi>:

int
atoi(const char *s)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28e:	00054683          	lbu	a3,0(a0)
 292:	fd06879b          	addiw	a5,a3,-48
 296:	0ff7f793          	zext.b	a5,a5
 29a:	4625                	li	a2,9
 29c:	02f66863          	bltu	a2,a5,2cc <atoi+0x44>
 2a0:	872a                	mv	a4,a0
  n = 0;
 2a2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2a4:	0705                	addi	a4,a4,1
 2a6:	0025179b          	slliw	a5,a0,0x2
 2aa:	9fa9                	addw	a5,a5,a0
 2ac:	0017979b          	slliw	a5,a5,0x1
 2b0:	9fb5                	addw	a5,a5,a3
 2b2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b6:	00074683          	lbu	a3,0(a4)
 2ba:	fd06879b          	addiw	a5,a3,-48
 2be:	0ff7f793          	zext.b	a5,a5
 2c2:	fef671e3          	bgeu	a2,a5,2a4 <atoi+0x1c>
  return n;
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  n = 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <atoi+0x3e>

00000000000002d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d6:	02b57463          	bgeu	a0,a1,2fe <memmove+0x2e>
    while(n-- > 0)
 2da:	00c05f63          	blez	a2,2f8 <memmove+0x28>
 2de:	1602                	slli	a2,a2,0x20
 2e0:	9201                	srli	a2,a2,0x20
 2e2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e8:	0585                	addi	a1,a1,1
 2ea:	0705                	addi	a4,a4,1
 2ec:	fff5c683          	lbu	a3,-1(a1)
 2f0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2f4:	fee79ae3          	bne	a5,a4,2e8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f8:	6422                	ld	s0,8(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
    dst += n;
 2fe:	00c50733          	add	a4,a0,a2
    src += n;
 302:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 304:	fec05ae3          	blez	a2,2f8 <memmove+0x28>
 308:	fff6079b          	addiw	a5,a2,-1
 30c:	1782                	slli	a5,a5,0x20
 30e:	9381                	srli	a5,a5,0x20
 310:	fff7c793          	not	a5,a5
 314:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 316:	15fd                	addi	a1,a1,-1
 318:	177d                	addi	a4,a4,-1
 31a:	0005c683          	lbu	a3,0(a1)
 31e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 322:	fee79ae3          	bne	a5,a4,316 <memmove+0x46>
 326:	bfc9                	j	2f8 <memmove+0x28>

0000000000000328 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 328:	1141                	addi	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32e:	ca05                	beqz	a2,35e <memcmp+0x36>
 330:	fff6069b          	addiw	a3,a2,-1
 334:	1682                	slli	a3,a3,0x20
 336:	9281                	srli	a3,a3,0x20
 338:	0685                	addi	a3,a3,1
 33a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 33c:	00054783          	lbu	a5,0(a0)
 340:	0005c703          	lbu	a4,0(a1)
 344:	00e79863          	bne	a5,a4,354 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 348:	0505                	addi	a0,a0,1
    p2++;
 34a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 34c:	fed518e3          	bne	a0,a3,33c <memcmp+0x14>
  }
  return 0;
 350:	4501                	li	a0,0
 352:	a019                	j	358 <memcmp+0x30>
      return *p1 - *p2;
 354:	40e7853b          	subw	a0,a5,a4
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret
  return 0;
 35e:	4501                	li	a0,0
 360:	bfe5                	j	358 <memcmp+0x30>

0000000000000362 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 362:	1141                	addi	sp,sp,-16
 364:	e406                	sd	ra,8(sp)
 366:	e022                	sd	s0,0(sp)
 368:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 36a:	00000097          	auipc	ra,0x0
 36e:	f66080e7          	jalr	-154(ra) # 2d0 <memmove>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37a:	4885                	li	a7,1
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exit>:
.global exit
exit:
 li a7, SYS_exit
 382:	4889                	li	a7,2
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <wait>:
.global wait
wait:
 li a7, SYS_wait
 38a:	488d                	li	a7,3
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 392:	4891                	li	a7,4
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <read>:
.global read
read:
 li a7, SYS_read
 39a:	4895                	li	a7,5
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <write>:
.global write
write:
 li a7, SYS_write
 3a2:	48c1                	li	a7,16
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <close>:
.global close
close:
 li a7, SYS_close
 3aa:	48d5                	li	a7,21
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b2:	4899                	li	a7,6
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ba:	489d                	li	a7,7
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <open>:
.global open
open:
 li a7, SYS_open
 3c2:	48bd                	li	a7,15
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ca:	48c5                	li	a7,17
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d2:	48c9                	li	a7,18
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3da:	48a1                	li	a7,8
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <link>:
.global link
link:
 li a7, SYS_link
 3e2:	48cd                	li	a7,19
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ea:	48d1                	li	a7,20
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f2:	48a5                	li	a7,9
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fa:	48a9                	li	a7,10
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 402:	48ad                	li	a7,11
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 40a:	48b1                	li	a7,12
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 412:	48b5                	li	a7,13
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41a:	48b9                	li	a7,14
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 422:	1101                	addi	sp,sp,-32
 424:	ec06                	sd	ra,24(sp)
 426:	e822                	sd	s0,16(sp)
 428:	1000                	addi	s0,sp,32
 42a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 42e:	4605                	li	a2,1
 430:	fef40593          	addi	a1,s0,-17
 434:	00000097          	auipc	ra,0x0
 438:	f6e080e7          	jalr	-146(ra) # 3a2 <write>
}
 43c:	60e2                	ld	ra,24(sp)
 43e:	6442                	ld	s0,16(sp)
 440:	6105                	addi	sp,sp,32
 442:	8082                	ret

0000000000000444 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 444:	7139                	addi	sp,sp,-64
 446:	fc06                	sd	ra,56(sp)
 448:	f822                	sd	s0,48(sp)
 44a:	f426                	sd	s1,40(sp)
 44c:	f04a                	sd	s2,32(sp)
 44e:	ec4e                	sd	s3,24(sp)
 450:	0080                	addi	s0,sp,64
 452:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 454:	c299                	beqz	a3,45a <printint+0x16>
 456:	0805c963          	bltz	a1,4e8 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 45a:	2581                	sext.w	a1,a1
  neg = 0;
 45c:	4881                	li	a7,0
 45e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 462:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 464:	2601                	sext.w	a2,a2
 466:	00000517          	auipc	a0,0x0
 46a:	4aa50513          	addi	a0,a0,1194 # 910 <digits>
 46e:	883a                	mv	a6,a4
 470:	2705                	addiw	a4,a4,1
 472:	02c5f7bb          	remuw	a5,a1,a2
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	97aa                	add	a5,a5,a0
 47c:	0007c783          	lbu	a5,0(a5)
 480:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 484:	0005879b          	sext.w	a5,a1
 488:	02c5d5bb          	divuw	a1,a1,a2
 48c:	0685                	addi	a3,a3,1
 48e:	fec7f0e3          	bgeu	a5,a2,46e <printint+0x2a>
  if(neg)
 492:	00088c63          	beqz	a7,4aa <printint+0x66>
    buf[i++] = '-';
 496:	fd070793          	addi	a5,a4,-48
 49a:	00878733          	add	a4,a5,s0
 49e:	02d00793          	li	a5,45
 4a2:	fef70823          	sb	a5,-16(a4)
 4a6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4aa:	02e05863          	blez	a4,4da <printint+0x96>
 4ae:	fc040793          	addi	a5,s0,-64
 4b2:	00e78933          	add	s2,a5,a4
 4b6:	fff78993          	addi	s3,a5,-1
 4ba:	99ba                	add	s3,s3,a4
 4bc:	377d                	addiw	a4,a4,-1
 4be:	1702                	slli	a4,a4,0x20
 4c0:	9301                	srli	a4,a4,0x20
 4c2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4c6:	fff94583          	lbu	a1,-1(s2)
 4ca:	8526                	mv	a0,s1
 4cc:	00000097          	auipc	ra,0x0
 4d0:	f56080e7          	jalr	-170(ra) # 422 <putc>
  while(--i >= 0)
 4d4:	197d                	addi	s2,s2,-1
 4d6:	ff3918e3          	bne	s2,s3,4c6 <printint+0x82>
}
 4da:	70e2                	ld	ra,56(sp)
 4dc:	7442                	ld	s0,48(sp)
 4de:	74a2                	ld	s1,40(sp)
 4e0:	7902                	ld	s2,32(sp)
 4e2:	69e2                	ld	s3,24(sp)
 4e4:	6121                	addi	sp,sp,64
 4e6:	8082                	ret
    x = -xx;
 4e8:	40b005bb          	negw	a1,a1
    neg = 1;
 4ec:	4885                	li	a7,1
    x = -xx;
 4ee:	bf85                	j	45e <printint+0x1a>

00000000000004f0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4f0:	7119                	addi	sp,sp,-128
 4f2:	fc86                	sd	ra,120(sp)
 4f4:	f8a2                	sd	s0,112(sp)
 4f6:	f4a6                	sd	s1,104(sp)
 4f8:	f0ca                	sd	s2,96(sp)
 4fa:	ecce                	sd	s3,88(sp)
 4fc:	e8d2                	sd	s4,80(sp)
 4fe:	e4d6                	sd	s5,72(sp)
 500:	e0da                	sd	s6,64(sp)
 502:	fc5e                	sd	s7,56(sp)
 504:	f862                	sd	s8,48(sp)
 506:	f466                	sd	s9,40(sp)
 508:	f06a                	sd	s10,32(sp)
 50a:	ec6e                	sd	s11,24(sp)
 50c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 50e:	0005c903          	lbu	s2,0(a1)
 512:	18090f63          	beqz	s2,6b0 <vprintf+0x1c0>
 516:	8aaa                	mv	s5,a0
 518:	8b32                	mv	s6,a2
 51a:	00158493          	addi	s1,a1,1
  state = 0;
 51e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 520:	02500a13          	li	s4,37
 524:	4c55                	li	s8,21
 526:	00000c97          	auipc	s9,0x0
 52a:	392c8c93          	addi	s9,s9,914 # 8b8 <malloc+0x104>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 52e:	02800d93          	li	s11,40
  putc(fd, 'x');
 532:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 534:	00000b97          	auipc	s7,0x0
 538:	3dcb8b93          	addi	s7,s7,988 # 910 <digits>
 53c:	a839                	j	55a <vprintf+0x6a>
        putc(fd, c);
 53e:	85ca                	mv	a1,s2
 540:	8556                	mv	a0,s5
 542:	00000097          	auipc	ra,0x0
 546:	ee0080e7          	jalr	-288(ra) # 422 <putc>
 54a:	a019                	j	550 <vprintf+0x60>
    } else if(state == '%'){
 54c:	01498d63          	beq	s3,s4,566 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 550:	0485                	addi	s1,s1,1
 552:	fff4c903          	lbu	s2,-1(s1)
 556:	14090d63          	beqz	s2,6b0 <vprintf+0x1c0>
    if(state == 0){
 55a:	fe0999e3          	bnez	s3,54c <vprintf+0x5c>
      if(c == '%'){
 55e:	ff4910e3          	bne	s2,s4,53e <vprintf+0x4e>
        state = '%';
 562:	89d2                	mv	s3,s4
 564:	b7f5                	j	550 <vprintf+0x60>
      if(c == 'd'){
 566:	11490c63          	beq	s2,s4,67e <vprintf+0x18e>
 56a:	f9d9079b          	addiw	a5,s2,-99
 56e:	0ff7f793          	zext.b	a5,a5
 572:	10fc6e63          	bltu	s8,a5,68e <vprintf+0x19e>
 576:	f9d9079b          	addiw	a5,s2,-99
 57a:	0ff7f713          	zext.b	a4,a5
 57e:	10ec6863          	bltu	s8,a4,68e <vprintf+0x19e>
 582:	00271793          	slli	a5,a4,0x2
 586:	97e6                	add	a5,a5,s9
 588:	439c                	lw	a5,0(a5)
 58a:	97e6                	add	a5,a5,s9
 58c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 58e:	008b0913          	addi	s2,s6,8
 592:	4685                	li	a3,1
 594:	4629                	li	a2,10
 596:	000b2583          	lw	a1,0(s6)
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	ea8080e7          	jalr	-344(ra) # 444 <printint>
 5a4:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a6:	4981                	li	s3,0
 5a8:	b765                	j	550 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5aa:	008b0913          	addi	s2,s6,8
 5ae:	4681                	li	a3,0
 5b0:	4629                	li	a2,10
 5b2:	000b2583          	lw	a1,0(s6)
 5b6:	8556                	mv	a0,s5
 5b8:	00000097          	auipc	ra,0x0
 5bc:	e8c080e7          	jalr	-372(ra) # 444 <printint>
 5c0:	8b4a                	mv	s6,s2
      state = 0;
 5c2:	4981                	li	s3,0
 5c4:	b771                	j	550 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5c6:	008b0913          	addi	s2,s6,8
 5ca:	4681                	li	a3,0
 5cc:	866a                	mv	a2,s10
 5ce:	000b2583          	lw	a1,0(s6)
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	e70080e7          	jalr	-400(ra) # 444 <printint>
 5dc:	8b4a                	mv	s6,s2
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	bf85                	j	550 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5e2:	008b0793          	addi	a5,s6,8
 5e6:	f8f43423          	sd	a5,-120(s0)
 5ea:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5ee:	03000593          	li	a1,48
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e2e080e7          	jalr	-466(ra) # 422 <putc>
  putc(fd, 'x');
 5fc:	07800593          	li	a1,120
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	e20080e7          	jalr	-480(ra) # 422 <putc>
 60a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 60c:	03c9d793          	srli	a5,s3,0x3c
 610:	97de                	add	a5,a5,s7
 612:	0007c583          	lbu	a1,0(a5)
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e0a080e7          	jalr	-502(ra) # 422 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 620:	0992                	slli	s3,s3,0x4
 622:	397d                	addiw	s2,s2,-1
 624:	fe0914e3          	bnez	s2,60c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 628:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b70d                	j	550 <vprintf+0x60>
        s = va_arg(ap, char*);
 630:	008b0913          	addi	s2,s6,8
 634:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 638:	02098163          	beqz	s3,65a <vprintf+0x16a>
        while(*s != 0){
 63c:	0009c583          	lbu	a1,0(s3)
 640:	c5ad                	beqz	a1,6aa <vprintf+0x1ba>
          putc(fd, *s);
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	dde080e7          	jalr	-546(ra) # 422 <putc>
          s++;
 64c:	0985                	addi	s3,s3,1
        while(*s != 0){
 64e:	0009c583          	lbu	a1,0(s3)
 652:	f9e5                	bnez	a1,642 <vprintf+0x152>
        s = va_arg(ap, char*);
 654:	8b4a                	mv	s6,s2
      state = 0;
 656:	4981                	li	s3,0
 658:	bde5                	j	550 <vprintf+0x60>
          s = "(null)";
 65a:	00000997          	auipc	s3,0x0
 65e:	25698993          	addi	s3,s3,598 # 8b0 <malloc+0xfc>
        while(*s != 0){
 662:	85ee                	mv	a1,s11
 664:	bff9                	j	642 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 666:	008b0913          	addi	s2,s6,8
 66a:	000b4583          	lbu	a1,0(s6)
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	db2080e7          	jalr	-590(ra) # 422 <putc>
 678:	8b4a                	mv	s6,s2
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bdd1                	j	550 <vprintf+0x60>
        putc(fd, c);
 67e:	85d2                	mv	a1,s4
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	da0080e7          	jalr	-608(ra) # 422 <putc>
      state = 0;
 68a:	4981                	li	s3,0
 68c:	b5d1                	j	550 <vprintf+0x60>
        putc(fd, '%');
 68e:	85d2                	mv	a1,s4
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	d90080e7          	jalr	-624(ra) # 422 <putc>
        putc(fd, c);
 69a:	85ca                	mv	a1,s2
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	d84080e7          	jalr	-636(ra) # 422 <putc>
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	b565                	j	550 <vprintf+0x60>
        s = va_arg(ap, char*);
 6aa:	8b4a                	mv	s6,s2
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	b54d                	j	550 <vprintf+0x60>
    }
  }
}
 6b0:	70e6                	ld	ra,120(sp)
 6b2:	7446                	ld	s0,112(sp)
 6b4:	74a6                	ld	s1,104(sp)
 6b6:	7906                	ld	s2,96(sp)
 6b8:	69e6                	ld	s3,88(sp)
 6ba:	6a46                	ld	s4,80(sp)
 6bc:	6aa6                	ld	s5,72(sp)
 6be:	6b06                	ld	s6,64(sp)
 6c0:	7be2                	ld	s7,56(sp)
 6c2:	7c42                	ld	s8,48(sp)
 6c4:	7ca2                	ld	s9,40(sp)
 6c6:	7d02                	ld	s10,32(sp)
 6c8:	6de2                	ld	s11,24(sp)
 6ca:	6109                	addi	sp,sp,128
 6cc:	8082                	ret

00000000000006ce <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ce:	715d                	addi	sp,sp,-80
 6d0:	ec06                	sd	ra,24(sp)
 6d2:	e822                	sd	s0,16(sp)
 6d4:	1000                	addi	s0,sp,32
 6d6:	e010                	sd	a2,0(s0)
 6d8:	e414                	sd	a3,8(s0)
 6da:	e818                	sd	a4,16(s0)
 6dc:	ec1c                	sd	a5,24(s0)
 6de:	03043023          	sd	a6,32(s0)
 6e2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ea:	8622                	mv	a2,s0
 6ec:	00000097          	auipc	ra,0x0
 6f0:	e04080e7          	jalr	-508(ra) # 4f0 <vprintf>
}
 6f4:	60e2                	ld	ra,24(sp)
 6f6:	6442                	ld	s0,16(sp)
 6f8:	6161                	addi	sp,sp,80
 6fa:	8082                	ret

00000000000006fc <printf>:

void
printf(const char *fmt, ...)
{
 6fc:	711d                	addi	sp,sp,-96
 6fe:	ec06                	sd	ra,24(sp)
 700:	e822                	sd	s0,16(sp)
 702:	1000                	addi	s0,sp,32
 704:	e40c                	sd	a1,8(s0)
 706:	e810                	sd	a2,16(s0)
 708:	ec14                	sd	a3,24(s0)
 70a:	f018                	sd	a4,32(s0)
 70c:	f41c                	sd	a5,40(s0)
 70e:	03043823          	sd	a6,48(s0)
 712:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 716:	00840613          	addi	a2,s0,8
 71a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 71e:	85aa                	mv	a1,a0
 720:	4505                	li	a0,1
 722:	00000097          	auipc	ra,0x0
 726:	dce080e7          	jalr	-562(ra) # 4f0 <vprintf>
}
 72a:	60e2                	ld	ra,24(sp)
 72c:	6442                	ld	s0,16(sp)
 72e:	6125                	addi	sp,sp,96
 730:	8082                	ret

0000000000000732 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 732:	1141                	addi	sp,sp,-16
 734:	e422                	sd	s0,8(sp)
 736:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 738:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73c:	00000797          	auipc	a5,0x0
 740:	1ec7b783          	ld	a5,492(a5) # 928 <freep>
 744:	a02d                	j	76e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 746:	4618                	lw	a4,8(a2)
 748:	9f2d                	addw	a4,a4,a1
 74a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 74e:	6398                	ld	a4,0(a5)
 750:	6310                	ld	a2,0(a4)
 752:	a83d                	j	790 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 754:	ff852703          	lw	a4,-8(a0)
 758:	9f31                	addw	a4,a4,a2
 75a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 75c:	ff053683          	ld	a3,-16(a0)
 760:	a091                	j	7a4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 762:	6398                	ld	a4,0(a5)
 764:	00e7e463          	bltu	a5,a4,76c <free+0x3a>
 768:	00e6ea63          	bltu	a3,a4,77c <free+0x4a>
{
 76c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76e:	fed7fae3          	bgeu	a5,a3,762 <free+0x30>
 772:	6398                	ld	a4,0(a5)
 774:	00e6e463          	bltu	a3,a4,77c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	fee7eae3          	bltu	a5,a4,76c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 77c:	ff852583          	lw	a1,-8(a0)
 780:	6390                	ld	a2,0(a5)
 782:	02059813          	slli	a6,a1,0x20
 786:	01c85713          	srli	a4,a6,0x1c
 78a:	9736                	add	a4,a4,a3
 78c:	fae60de3          	beq	a2,a4,746 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 790:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 794:	4790                	lw	a2,8(a5)
 796:	02061593          	slli	a1,a2,0x20
 79a:	01c5d713          	srli	a4,a1,0x1c
 79e:	973e                	add	a4,a4,a5
 7a0:	fae68ae3          	beq	a3,a4,754 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7a4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7a6:	00000717          	auipc	a4,0x0
 7aa:	18f73123          	sd	a5,386(a4) # 928 <freep>
}
 7ae:	6422                	ld	s0,8(sp)
 7b0:	0141                	addi	sp,sp,16
 7b2:	8082                	ret

00000000000007b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b4:	7139                	addi	sp,sp,-64
 7b6:	fc06                	sd	ra,56(sp)
 7b8:	f822                	sd	s0,48(sp)
 7ba:	f426                	sd	s1,40(sp)
 7bc:	f04a                	sd	s2,32(sp)
 7be:	ec4e                	sd	s3,24(sp)
 7c0:	e852                	sd	s4,16(sp)
 7c2:	e456                	sd	s5,8(sp)
 7c4:	e05a                	sd	s6,0(sp)
 7c6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c8:	02051493          	slli	s1,a0,0x20
 7cc:	9081                	srli	s1,s1,0x20
 7ce:	04bd                	addi	s1,s1,15
 7d0:	8091                	srli	s1,s1,0x4
 7d2:	0014899b          	addiw	s3,s1,1
 7d6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7d8:	00000517          	auipc	a0,0x0
 7dc:	15053503          	ld	a0,336(a0) # 928 <freep>
 7e0:	c515                	beqz	a0,80c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7e4:	4798                	lw	a4,8(a5)
 7e6:	02977f63          	bgeu	a4,s1,824 <malloc+0x70>
 7ea:	8a4e                	mv	s4,s3
 7ec:	0009871b          	sext.w	a4,s3
 7f0:	6685                	lui	a3,0x1
 7f2:	00d77363          	bgeu	a4,a3,7f8 <malloc+0x44>
 7f6:	6a05                	lui	s4,0x1
 7f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7fc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 800:	00000917          	auipc	s2,0x0
 804:	12890913          	addi	s2,s2,296 # 928 <freep>
  if(p == (char*)-1)
 808:	5afd                	li	s5,-1
 80a:	a895                	j	87e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 80c:	00000797          	auipc	a5,0x0
 810:	12478793          	addi	a5,a5,292 # 930 <base>
 814:	00000717          	auipc	a4,0x0
 818:	10f73a23          	sd	a5,276(a4) # 928 <freep>
 81c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 81e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 822:	b7e1                	j	7ea <malloc+0x36>
      if(p->s.size == nunits)
 824:	02e48c63          	beq	s1,a4,85c <malloc+0xa8>
        p->s.size -= nunits;
 828:	4137073b          	subw	a4,a4,s3
 82c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 82e:	02071693          	slli	a3,a4,0x20
 832:	01c6d713          	srli	a4,a3,0x1c
 836:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 838:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 83c:	00000717          	auipc	a4,0x0
 840:	0ea73623          	sd	a0,236(a4) # 928 <freep>
      return (void*)(p + 1);
 844:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 848:	70e2                	ld	ra,56(sp)
 84a:	7442                	ld	s0,48(sp)
 84c:	74a2                	ld	s1,40(sp)
 84e:	7902                	ld	s2,32(sp)
 850:	69e2                	ld	s3,24(sp)
 852:	6a42                	ld	s4,16(sp)
 854:	6aa2                	ld	s5,8(sp)
 856:	6b02                	ld	s6,0(sp)
 858:	6121                	addi	sp,sp,64
 85a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 85c:	6398                	ld	a4,0(a5)
 85e:	e118                	sd	a4,0(a0)
 860:	bff1                	j	83c <malloc+0x88>
  hp->s.size = nu;
 862:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 866:	0541                	addi	a0,a0,16
 868:	00000097          	auipc	ra,0x0
 86c:	eca080e7          	jalr	-310(ra) # 732 <free>
  return freep;
 870:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 874:	d971                	beqz	a0,848 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 876:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 878:	4798                	lw	a4,8(a5)
 87a:	fa9775e3          	bgeu	a4,s1,824 <malloc+0x70>
    if(p == freep)
 87e:	00093703          	ld	a4,0(s2)
 882:	853e                	mv	a0,a5
 884:	fef719e3          	bne	a4,a5,876 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 888:	8552                	mv	a0,s4
 88a:	00000097          	auipc	ra,0x0
 88e:	b80080e7          	jalr	-1152(ra) # 40a <sbrk>
  if(p == (char*)-1)
 892:	fd5518e3          	bne	a0,s5,862 <malloc+0xae>
        return 0;
 896:	4501                	li	a0,0
 898:	bf45                	j	848 <malloc+0x94>
