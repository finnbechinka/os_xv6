
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	0880                	addi	s0,sp,80
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
  m = 0;
 134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 136:	3ff00b93          	li	s7,1023
 13a:	00001a97          	auipc	s5,0x1
 13e:	a36a8a93          	addi	s5,s5,-1482 # b70 <buf>
 142:	a0a1                	j	18a <grep+0x70>
      p = q+1;
 144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 148:	45a9                	li	a1,10
 14a:	854a                	mv	a0,s2
 14c:	00000097          	auipc	ra,0x0
 150:	278080e7          	jalr	632(ra) # 3c4 <strchr>
 154:	84aa                	mv	s1,a0
 156:	c905                	beqz	a0,186 <grep+0x6c>
      *q = 0;
 158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15c:	85ca                	mv	a1,s2
 15e:	854e                	mv	a0,s3
 160:	00000097          	auipc	ra,0x0
 164:	f6c080e7          	jalr	-148(ra) # cc <match>
 168:	dd71                	beqz	a0,144 <grep+0x2a>
        *q = '\n';
 16a:	47a9                	li	a5,10
 16c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 170:	00148613          	addi	a2,s1,1
 174:	4126063b          	subw	a2,a2,s2
 178:	85ca                	mv	a1,s2
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	440080e7          	jalr	1088(ra) # 5bc <write>
 184:	b7c1                	j	144 <grep+0x2a>
    if(m > 0){
 186:	03404563          	bgtz	s4,1b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18a:	414b863b          	subw	a2,s7,s4
 18e:	014a85b3          	add	a1,s5,s4
 192:	855a                	mv	a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	420080e7          	jalr	1056(ra) # 5b4 <read>
 19c:	02a05663          	blez	a0,1c8 <grep+0xae>
    m += n;
 1a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1a4:	014a87b3          	add	a5,s5,s4
 1a8:	00078023          	sb	zero,0(a5)
    p = buf;
 1ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1ae:	bf69                	j	148 <grep+0x2e>
      m -= p - buf;
 1b0:	415907b3          	sub	a5,s2,s5
 1b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1b8:	8652                	mv	a2,s4
 1ba:	85ca                	mv	a1,s2
 1bc:	8556                	mv	a0,s5
 1be:	00000097          	auipc	ra,0x0
 1c2:	32c080e7          	jalr	812(ra) # 4ea <memmove>
 1c6:	b7d1                	j	18a <grep+0x70>
}
 1c8:	60a6                	ld	ra,72(sp)
 1ca:	6406                	ld	s0,64(sp)
 1cc:	74e2                	ld	s1,56(sp)
 1ce:	7942                	ld	s2,48(sp)
 1d0:	79a2                	ld	s3,40(sp)
 1d2:	7a02                	ld	s4,32(sp)
 1d4:	6ae2                	ld	s5,24(sp)
 1d6:	6b42                	ld	s6,16(sp)
 1d8:	6ba2                	ld	s7,8(sp)
 1da:	6161                	addi	sp,sp,80
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	7139                	addi	sp,sp,-64
 1e0:	fc06                	sd	ra,56(sp)
 1e2:	f822                	sd	s0,48(sp)
 1e4:	f426                	sd	s1,40(sp)
 1e6:	f04a                	sd	s2,32(sp)
 1e8:	ec4e                	sd	s3,24(sp)
 1ea:	e852                	sd	s4,16(sp)
 1ec:	e456                	sd	s5,8(sp)
 1ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1f0:	4785                	li	a5,1
 1f2:	04a7de63          	bge	a5,a0,24e <main+0x70>
  pattern = argv[1];
 1f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1fa:	4789                	li	a5,2
 1fc:	06a7d763          	bge	a5,a0,26a <main+0x8c>
 200:	01058913          	addi	s2,a1,16
 204:	ffd5099b          	addiw	s3,a0,-3
 208:	02099793          	slli	a5,s3,0x20
 20c:	01d7d993          	srli	s3,a5,0x1d
 210:	05e1                	addi	a1,a1,24
 212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 214:	4581                	li	a1,0
 216:	00093503          	ld	a0,0(s2)
 21a:	00000097          	auipc	ra,0x0
 21e:	3c2080e7          	jalr	962(ra) # 5dc <open>
 222:	84aa                	mv	s1,a0
 224:	04054e63          	bltz	a0,280 <main+0xa2>
    grep(pattern, fd);
 228:	85aa                	mv	a1,a0
 22a:	8552                	mv	a0,s4
 22c:	00000097          	auipc	ra,0x0
 230:	eee080e7          	jalr	-274(ra) # 11a <grep>
    close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	38e080e7          	jalr	910(ra) # 5c4 <close>
  for(i = 2; i < argc; i++){
 23e:	0921                	addi	s2,s2,8
 240:	fd391ae3          	bne	s2,s3,214 <main+0x36>
  exit(0);
 244:	4501                	li	a0,0
 246:	00000097          	auipc	ra,0x0
 24a:	356080e7          	jalr	854(ra) # 59c <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 24e:	00001597          	auipc	a1,0x1
 252:	86a58593          	addi	a1,a1,-1942 # ab8 <malloc+0xea>
 256:	4509                	li	a0,2
 258:	00000097          	auipc	ra,0x0
 25c:	690080e7          	jalr	1680(ra) # 8e8 <fprintf>
    exit(1);
 260:	4505                	li	a0,1
 262:	00000097          	auipc	ra,0x0
 266:	33a080e7          	jalr	826(ra) # 59c <exit>
    grep(pattern, 0);
 26a:	4581                	li	a1,0
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	eac080e7          	jalr	-340(ra) # 11a <grep>
    exit(0);
 276:	4501                	li	a0,0
 278:	00000097          	auipc	ra,0x0
 27c:	324080e7          	jalr	804(ra) # 59c <exit>
      printf("grep: cannot open %s\n", argv[i]);
 280:	00093583          	ld	a1,0(s2)
 284:	00001517          	auipc	a0,0x1
 288:	85450513          	addi	a0,a0,-1964 # ad8 <malloc+0x10a>
 28c:	00000097          	auipc	ra,0x0
 290:	68a080e7          	jalr	1674(ra) # 916 <printf>
      exit(1);
 294:	4505                	li	a0,1
 296:	00000097          	auipc	ra,0x0
 29a:	306080e7          	jalr	774(ra) # 59c <exit>

000000000000029e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a4:	87aa                	mv	a5,a0
 2a6:	0585                	addi	a1,a1,1
 2a8:	0785                	addi	a5,a5,1
 2aa:	fff5c703          	lbu	a4,-1(a1)
 2ae:	fee78fa3          	sb	a4,-1(a5)
 2b2:	fb75                	bnez	a4,2a6 <strcpy+0x8>
    ;
  return os;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	cb91                	beqz	a5,2d8 <strcmp+0x1e>
 2c6:	0005c703          	lbu	a4,0(a1)
 2ca:	00f71763          	bne	a4,a5,2d8 <strcmp+0x1e>
    p++, q++;
 2ce:	0505                	addi	a0,a0,1
 2d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	fbe5                	bnez	a5,2c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2d8:	0005c503          	lbu	a0,0(a1)
}
 2dc:	40a7853b          	subw	a0,a5,a0
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret

00000000000002e6 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	cf91                	beqz	a5,30c <strlen+0x26>
 2f2:	0505                	addi	a0,a0,1
 2f4:	87aa                	mv	a5,a0
 2f6:	4685                	li	a3,1
 2f8:	9e89                	subw	a3,a3,a0
 2fa:	00f6853b          	addw	a0,a3,a5
 2fe:	0785                	addi	a5,a5,1
 300:	fff7c703          	lbu	a4,-1(a5)
 304:	fb7d                	bnez	a4,2fa <strlen+0x14>
    ;
  return n;
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  for(n = 0; s[n]; n++)
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <strlen+0x20>

0000000000000310 <strsub>:
int strsub(const char *s, const char *sub){
 310:	7139                	addi	sp,sp,-64
 312:	fc06                	sd	ra,56(sp)
 314:	f822                	sd	s0,48(sp)
 316:	f426                	sd	s1,40(sp)
 318:	f04a                	sd	s2,32(sp)
 31a:	ec4e                	sd	s3,24(sp)
 31c:	e852                	sd	s4,16(sp)
 31e:	e456                	sd	s5,8(sp)
 320:	0080                	addi	s0,sp,64
 322:	8a2a                	mv	s4,a0
 324:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 326:	84aa                	mv	s1,a0
 328:	4901                	li	s2,0
 32a:	a019                	j	330 <strsub+0x20>
 32c:	2905                	addiw	s2,s2,1
 32e:	0485                	addi	s1,s1,1
 330:	8552                	mv	a0,s4
 332:	00000097          	auipc	ra,0x0
 336:	fb4080e7          	jalr	-76(ra) # 2e6 <strlen>
 33a:	2501                	sext.w	a0,a0
 33c:	04a97863          	bgeu	s2,a0,38c <strsub+0x7c>
    if(s[i] == sub[0]){
 340:	8aa6                	mv	s5,s1
 342:	0004c703          	lbu	a4,0(s1)
 346:	0009c783          	lbu	a5,0(s3)
 34a:	fef711e3          	bne	a4,a5,32c <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 34e:	854e                	mv	a0,s3
 350:	00000097          	auipc	ra,0x0
 354:	f96080e7          	jalr	-106(ra) # 2e6 <strlen>
 358:	0005059b          	sext.w	a1,a0
 35c:	ffe5061b          	addiw	a2,a0,-2
 360:	1602                	slli	a2,a2,0x20
 362:	9201                	srli	a2,a2,0x20
 364:	0609                	addi	a2,a2,2
 366:	4785                	li	a5,1
 368:	0007871b          	sext.w	a4,a5
 36c:	fcb770e3          	bgeu	a4,a1,32c <strsub+0x1c>
        if(s[j+i] != sub[j]){
 370:	00fa86b3          	add	a3,s5,a5
 374:	00f98733          	add	a4,s3,a5
 378:	0006c683          	lbu	a3,0(a3)
 37c:	00074703          	lbu	a4,0(a4)
 380:	fae696e3          	bne	a3,a4,32c <strsub+0x1c>
        if(j == strlen(sub) -1){
 384:	0785                	addi	a5,a5,1
 386:	fec791e3          	bne	a5,a2,368 <strsub+0x58>
 38a:	a011                	j	38e <strsub+0x7e>
  return -1;
 38c:	597d                	li	s2,-1
}
 38e:	854a                	mv	a0,s2
 390:	70e2                	ld	ra,56(sp)
 392:	7442                	ld	s0,48(sp)
 394:	74a2                	ld	s1,40(sp)
 396:	7902                	ld	s2,32(sp)
 398:	69e2                	ld	s3,24(sp)
 39a:	6a42                	ld	s4,16(sp)
 39c:	6aa2                	ld	s5,8(sp)
 39e:	6121                	addi	sp,sp,64
 3a0:	8082                	ret

00000000000003a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e422                	sd	s0,8(sp)
 3a6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3a8:	ca19                	beqz	a2,3be <memset+0x1c>
 3aa:	87aa                	mv	a5,a0
 3ac:	1602                	slli	a2,a2,0x20
 3ae:	9201                	srli	a2,a2,0x20
 3b0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3b4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3b8:	0785                	addi	a5,a5,1
 3ba:	fee79de3          	bne	a5,a4,3b4 <memset+0x12>
  }
  return dst;
}
 3be:	6422                	ld	s0,8(sp)
 3c0:	0141                	addi	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <strchr>:

char*
strchr(const char *s, char c)
{
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3ca:	00054783          	lbu	a5,0(a0)
 3ce:	cb99                	beqz	a5,3e4 <strchr+0x20>
    if(*s == c)
 3d0:	00f58763          	beq	a1,a5,3de <strchr+0x1a>
  for(; *s; s++)
 3d4:	0505                	addi	a0,a0,1
 3d6:	00054783          	lbu	a5,0(a0)
 3da:	fbfd                	bnez	a5,3d0 <strchr+0xc>
      return (char*)s;
  return 0;
 3dc:	4501                	li	a0,0
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  return 0;
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <strchr+0x1a>

00000000000003e8 <gets>:

char*
gets(char *buf, int max)
{
 3e8:	711d                	addi	sp,sp,-96
 3ea:	ec86                	sd	ra,88(sp)
 3ec:	e8a2                	sd	s0,80(sp)
 3ee:	e4a6                	sd	s1,72(sp)
 3f0:	e0ca                	sd	s2,64(sp)
 3f2:	fc4e                	sd	s3,56(sp)
 3f4:	f852                	sd	s4,48(sp)
 3f6:	f456                	sd	s5,40(sp)
 3f8:	f05a                	sd	s6,32(sp)
 3fa:	ec5e                	sd	s7,24(sp)
 3fc:	1080                	addi	s0,sp,96
 3fe:	8baa                	mv	s7,a0
 400:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 402:	892a                	mv	s2,a0
 404:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 406:	4aa9                	li	s5,10
 408:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 40a:	89a6                	mv	s3,s1
 40c:	2485                	addiw	s1,s1,1
 40e:	0344d863          	bge	s1,s4,43e <gets+0x56>
    cc = read(0, &c, 1);
 412:	4605                	li	a2,1
 414:	faf40593          	addi	a1,s0,-81
 418:	4501                	li	a0,0
 41a:	00000097          	auipc	ra,0x0
 41e:	19a080e7          	jalr	410(ra) # 5b4 <read>
    if(cc < 1)
 422:	00a05e63          	blez	a0,43e <gets+0x56>
    buf[i++] = c;
 426:	faf44783          	lbu	a5,-81(s0)
 42a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 42e:	01578763          	beq	a5,s5,43c <gets+0x54>
 432:	0905                	addi	s2,s2,1
 434:	fd679be3          	bne	a5,s6,40a <gets+0x22>
  for(i=0; i+1 < max; ){
 438:	89a6                	mv	s3,s1
 43a:	a011                	j	43e <gets+0x56>
 43c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 43e:	99de                	add	s3,s3,s7
 440:	00098023          	sb	zero,0(s3)
  return buf;
}
 444:	855e                	mv	a0,s7
 446:	60e6                	ld	ra,88(sp)
 448:	6446                	ld	s0,80(sp)
 44a:	64a6                	ld	s1,72(sp)
 44c:	6906                	ld	s2,64(sp)
 44e:	79e2                	ld	s3,56(sp)
 450:	7a42                	ld	s4,48(sp)
 452:	7aa2                	ld	s5,40(sp)
 454:	7b02                	ld	s6,32(sp)
 456:	6be2                	ld	s7,24(sp)
 458:	6125                	addi	sp,sp,96
 45a:	8082                	ret

000000000000045c <stat>:

int
stat(const char *n, struct stat *st)
{
 45c:	1101                	addi	sp,sp,-32
 45e:	ec06                	sd	ra,24(sp)
 460:	e822                	sd	s0,16(sp)
 462:	e426                	sd	s1,8(sp)
 464:	e04a                	sd	s2,0(sp)
 466:	1000                	addi	s0,sp,32
 468:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 46a:	4581                	li	a1,0
 46c:	00000097          	auipc	ra,0x0
 470:	170080e7          	jalr	368(ra) # 5dc <open>
  if(fd < 0)
 474:	02054563          	bltz	a0,49e <stat+0x42>
 478:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 47a:	85ca                	mv	a1,s2
 47c:	00000097          	auipc	ra,0x0
 480:	178080e7          	jalr	376(ra) # 5f4 <fstat>
 484:	892a                	mv	s2,a0
  close(fd);
 486:	8526                	mv	a0,s1
 488:	00000097          	auipc	ra,0x0
 48c:	13c080e7          	jalr	316(ra) # 5c4 <close>
  return r;
}
 490:	854a                	mv	a0,s2
 492:	60e2                	ld	ra,24(sp)
 494:	6442                	ld	s0,16(sp)
 496:	64a2                	ld	s1,8(sp)
 498:	6902                	ld	s2,0(sp)
 49a:	6105                	addi	sp,sp,32
 49c:	8082                	ret
    return -1;
 49e:	597d                	li	s2,-1
 4a0:	bfc5                	j	490 <stat+0x34>

00000000000004a2 <atoi>:

int
atoi(const char *s)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a8:	00054683          	lbu	a3,0(a0)
 4ac:	fd06879b          	addiw	a5,a3,-48
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	4625                	li	a2,9
 4b6:	02f66863          	bltu	a2,a5,4e6 <atoi+0x44>
 4ba:	872a                	mv	a4,a0
  n = 0;
 4bc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4be:	0705                	addi	a4,a4,1
 4c0:	0025179b          	slliw	a5,a0,0x2
 4c4:	9fa9                	addw	a5,a5,a0
 4c6:	0017979b          	slliw	a5,a5,0x1
 4ca:	9fb5                	addw	a5,a5,a3
 4cc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4d0:	00074683          	lbu	a3,0(a4)
 4d4:	fd06879b          	addiw	a5,a3,-48
 4d8:	0ff7f793          	zext.b	a5,a5
 4dc:	fef671e3          	bgeu	a2,a5,4be <atoi+0x1c>
  return n;
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret
  n = 0;
 4e6:	4501                	li	a0,0
 4e8:	bfe5                	j	4e0 <atoi+0x3e>

00000000000004ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4f0:	02b57463          	bgeu	a0,a1,518 <memmove+0x2e>
    while(n-- > 0)
 4f4:	00c05f63          	blez	a2,512 <memmove+0x28>
 4f8:	1602                	slli	a2,a2,0x20
 4fa:	9201                	srli	a2,a2,0x20
 4fc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 500:	872a                	mv	a4,a0
      *dst++ = *src++;
 502:	0585                	addi	a1,a1,1
 504:	0705                	addi	a4,a4,1
 506:	fff5c683          	lbu	a3,-1(a1)
 50a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 50e:	fee79ae3          	bne	a5,a4,502 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
    dst += n;
 518:	00c50733          	add	a4,a0,a2
    src += n;
 51c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 51e:	fec05ae3          	blez	a2,512 <memmove+0x28>
 522:	fff6079b          	addiw	a5,a2,-1
 526:	1782                	slli	a5,a5,0x20
 528:	9381                	srli	a5,a5,0x20
 52a:	fff7c793          	not	a5,a5
 52e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 530:	15fd                	addi	a1,a1,-1
 532:	177d                	addi	a4,a4,-1
 534:	0005c683          	lbu	a3,0(a1)
 538:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 53c:	fee79ae3          	bne	a5,a4,530 <memmove+0x46>
 540:	bfc9                	j	512 <memmove+0x28>

0000000000000542 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 542:	1141                	addi	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 548:	ca05                	beqz	a2,578 <memcmp+0x36>
 54a:	fff6069b          	addiw	a3,a2,-1
 54e:	1682                	slli	a3,a3,0x20
 550:	9281                	srli	a3,a3,0x20
 552:	0685                	addi	a3,a3,1
 554:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 556:	00054783          	lbu	a5,0(a0)
 55a:	0005c703          	lbu	a4,0(a1)
 55e:	00e79863          	bne	a5,a4,56e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 562:	0505                	addi	a0,a0,1
    p2++;
 564:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 566:	fed518e3          	bne	a0,a3,556 <memcmp+0x14>
  }
  return 0;
 56a:	4501                	li	a0,0
 56c:	a019                	j	572 <memcmp+0x30>
      return *p1 - *p2;
 56e:	40e7853b          	subw	a0,a5,a4
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	addi	sp,sp,16
 576:	8082                	ret
  return 0;
 578:	4501                	li	a0,0
 57a:	bfe5                	j	572 <memcmp+0x30>

000000000000057c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 57c:	1141                	addi	sp,sp,-16
 57e:	e406                	sd	ra,8(sp)
 580:	e022                	sd	s0,0(sp)
 582:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 584:	00000097          	auipc	ra,0x0
 588:	f66080e7          	jalr	-154(ra) # 4ea <memmove>
}
 58c:	60a2                	ld	ra,8(sp)
 58e:	6402                	ld	s0,0(sp)
 590:	0141                	addi	sp,sp,16
 592:	8082                	ret

0000000000000594 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 594:	4885                	li	a7,1
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <exit>:
.global exit
exit:
 li a7, SYS_exit
 59c:	4889                	li	a7,2
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a4:	488d                	li	a7,3
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ac:	4891                	li	a7,4
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <read>:
.global read
read:
 li a7, SYS_read
 5b4:	4895                	li	a7,5
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <write>:
.global write
write:
 li a7, SYS_write
 5bc:	48c1                	li	a7,16
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <close>:
.global close
close:
 li a7, SYS_close
 5c4:	48d5                	li	a7,21
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <kill>:
.global kill
kill:
 li a7, SYS_kill
 5cc:	4899                	li	a7,6
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d4:	489d                	li	a7,7
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <open>:
.global open
open:
 li a7, SYS_open
 5dc:	48bd                	li	a7,15
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e4:	48c5                	li	a7,17
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5ec:	48c9                	li	a7,18
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f4:	48a1                	li	a7,8
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <link>:
.global link
link:
 li a7, SYS_link
 5fc:	48cd                	li	a7,19
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 604:	48d1                	li	a7,20
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 60c:	48a5                	li	a7,9
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <dup>:
.global dup
dup:
 li a7, SYS_dup
 614:	48a9                	li	a7,10
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 61c:	48ad                	li	a7,11
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 624:	48b1                	li	a7,12
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 62c:	48b5                	li	a7,13
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 634:	48b9                	li	a7,14
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 63c:	1101                	addi	sp,sp,-32
 63e:	ec06                	sd	ra,24(sp)
 640:	e822                	sd	s0,16(sp)
 642:	1000                	addi	s0,sp,32
 644:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 648:	4605                	li	a2,1
 64a:	fef40593          	addi	a1,s0,-17
 64e:	00000097          	auipc	ra,0x0
 652:	f6e080e7          	jalr	-146(ra) # 5bc <write>
}
 656:	60e2                	ld	ra,24(sp)
 658:	6442                	ld	s0,16(sp)
 65a:	6105                	addi	sp,sp,32
 65c:	8082                	ret

000000000000065e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 65e:	7139                	addi	sp,sp,-64
 660:	fc06                	sd	ra,56(sp)
 662:	f822                	sd	s0,48(sp)
 664:	f426                	sd	s1,40(sp)
 666:	f04a                	sd	s2,32(sp)
 668:	ec4e                	sd	s3,24(sp)
 66a:	0080                	addi	s0,sp,64
 66c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66e:	c299                	beqz	a3,674 <printint+0x16>
 670:	0805c963          	bltz	a1,702 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 674:	2581                	sext.w	a1,a1
  neg = 0;
 676:	4881                	li	a7,0
 678:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 67c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 67e:	2601                	sext.w	a2,a2
 680:	00000517          	auipc	a0,0x0
 684:	4d050513          	addi	a0,a0,1232 # b50 <digits>
 688:	883a                	mv	a6,a4
 68a:	2705                	addiw	a4,a4,1
 68c:	02c5f7bb          	remuw	a5,a1,a2
 690:	1782                	slli	a5,a5,0x20
 692:	9381                	srli	a5,a5,0x20
 694:	97aa                	add	a5,a5,a0
 696:	0007c783          	lbu	a5,0(a5)
 69a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 69e:	0005879b          	sext.w	a5,a1
 6a2:	02c5d5bb          	divuw	a1,a1,a2
 6a6:	0685                	addi	a3,a3,1
 6a8:	fec7f0e3          	bgeu	a5,a2,688 <printint+0x2a>
  if(neg)
 6ac:	00088c63          	beqz	a7,6c4 <printint+0x66>
    buf[i++] = '-';
 6b0:	fd070793          	addi	a5,a4,-48
 6b4:	00878733          	add	a4,a5,s0
 6b8:	02d00793          	li	a5,45
 6bc:	fef70823          	sb	a5,-16(a4)
 6c0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6c4:	02e05863          	blez	a4,6f4 <printint+0x96>
 6c8:	fc040793          	addi	a5,s0,-64
 6cc:	00e78933          	add	s2,a5,a4
 6d0:	fff78993          	addi	s3,a5,-1
 6d4:	99ba                	add	s3,s3,a4
 6d6:	377d                	addiw	a4,a4,-1
 6d8:	1702                	slli	a4,a4,0x20
 6da:	9301                	srli	a4,a4,0x20
 6dc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6e0:	fff94583          	lbu	a1,-1(s2)
 6e4:	8526                	mv	a0,s1
 6e6:	00000097          	auipc	ra,0x0
 6ea:	f56080e7          	jalr	-170(ra) # 63c <putc>
  while(--i >= 0)
 6ee:	197d                	addi	s2,s2,-1
 6f0:	ff3918e3          	bne	s2,s3,6e0 <printint+0x82>
}
 6f4:	70e2                	ld	ra,56(sp)
 6f6:	7442                	ld	s0,48(sp)
 6f8:	74a2                	ld	s1,40(sp)
 6fa:	7902                	ld	s2,32(sp)
 6fc:	69e2                	ld	s3,24(sp)
 6fe:	6121                	addi	sp,sp,64
 700:	8082                	ret
    x = -xx;
 702:	40b005bb          	negw	a1,a1
    neg = 1;
 706:	4885                	li	a7,1
    x = -xx;
 708:	bf85                	j	678 <printint+0x1a>

000000000000070a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 70a:	7119                	addi	sp,sp,-128
 70c:	fc86                	sd	ra,120(sp)
 70e:	f8a2                	sd	s0,112(sp)
 710:	f4a6                	sd	s1,104(sp)
 712:	f0ca                	sd	s2,96(sp)
 714:	ecce                	sd	s3,88(sp)
 716:	e8d2                	sd	s4,80(sp)
 718:	e4d6                	sd	s5,72(sp)
 71a:	e0da                	sd	s6,64(sp)
 71c:	fc5e                	sd	s7,56(sp)
 71e:	f862                	sd	s8,48(sp)
 720:	f466                	sd	s9,40(sp)
 722:	f06a                	sd	s10,32(sp)
 724:	ec6e                	sd	s11,24(sp)
 726:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 728:	0005c903          	lbu	s2,0(a1)
 72c:	18090f63          	beqz	s2,8ca <vprintf+0x1c0>
 730:	8aaa                	mv	s5,a0
 732:	8b32                	mv	s6,a2
 734:	00158493          	addi	s1,a1,1
  state = 0;
 738:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 73a:	02500a13          	li	s4,37
 73e:	4c55                	li	s8,21
 740:	00000c97          	auipc	s9,0x0
 744:	3b8c8c93          	addi	s9,s9,952 # af8 <malloc+0x12a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 748:	02800d93          	li	s11,40
  putc(fd, 'x');
 74c:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74e:	00000b97          	auipc	s7,0x0
 752:	402b8b93          	addi	s7,s7,1026 # b50 <digits>
 756:	a839                	j	774 <vprintf+0x6a>
        putc(fd, c);
 758:	85ca                	mv	a1,s2
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	ee0080e7          	jalr	-288(ra) # 63c <putc>
 764:	a019                	j	76a <vprintf+0x60>
    } else if(state == '%'){
 766:	01498d63          	beq	s3,s4,780 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 76a:	0485                	addi	s1,s1,1
 76c:	fff4c903          	lbu	s2,-1(s1)
 770:	14090d63          	beqz	s2,8ca <vprintf+0x1c0>
    if(state == 0){
 774:	fe0999e3          	bnez	s3,766 <vprintf+0x5c>
      if(c == '%'){
 778:	ff4910e3          	bne	s2,s4,758 <vprintf+0x4e>
        state = '%';
 77c:	89d2                	mv	s3,s4
 77e:	b7f5                	j	76a <vprintf+0x60>
      if(c == 'd'){
 780:	11490c63          	beq	s2,s4,898 <vprintf+0x18e>
 784:	f9d9079b          	addiw	a5,s2,-99
 788:	0ff7f793          	zext.b	a5,a5
 78c:	10fc6e63          	bltu	s8,a5,8a8 <vprintf+0x19e>
 790:	f9d9079b          	addiw	a5,s2,-99
 794:	0ff7f713          	zext.b	a4,a5
 798:	10ec6863          	bltu	s8,a4,8a8 <vprintf+0x19e>
 79c:	00271793          	slli	a5,a4,0x2
 7a0:	97e6                	add	a5,a5,s9
 7a2:	439c                	lw	a5,0(a5)
 7a4:	97e6                	add	a5,a5,s9
 7a6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7a8:	008b0913          	addi	s2,s6,8
 7ac:	4685                	li	a3,1
 7ae:	4629                	li	a2,10
 7b0:	000b2583          	lw	a1,0(s6)
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	ea8080e7          	jalr	-344(ra) # 65e <printint>
 7be:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	b765                	j	76a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c4:	008b0913          	addi	s2,s6,8
 7c8:	4681                	li	a3,0
 7ca:	4629                	li	a2,10
 7cc:	000b2583          	lw	a1,0(s6)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e8c080e7          	jalr	-372(ra) # 65e <printint>
 7da:	8b4a                	mv	s6,s2
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	b771                	j	76a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7e0:	008b0913          	addi	s2,s6,8
 7e4:	4681                	li	a3,0
 7e6:	866a                	mv	a2,s10
 7e8:	000b2583          	lw	a1,0(s6)
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	e70080e7          	jalr	-400(ra) # 65e <printint>
 7f6:	8b4a                	mv	s6,s2
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bf85                	j	76a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7fc:	008b0793          	addi	a5,s6,8
 800:	f8f43423          	sd	a5,-120(s0)
 804:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 808:	03000593          	li	a1,48
 80c:	8556                	mv	a0,s5
 80e:	00000097          	auipc	ra,0x0
 812:	e2e080e7          	jalr	-466(ra) # 63c <putc>
  putc(fd, 'x');
 816:	07800593          	li	a1,120
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e20080e7          	jalr	-480(ra) # 63c <putc>
 824:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 826:	03c9d793          	srli	a5,s3,0x3c
 82a:	97de                	add	a5,a5,s7
 82c:	0007c583          	lbu	a1,0(a5)
 830:	8556                	mv	a0,s5
 832:	00000097          	auipc	ra,0x0
 836:	e0a080e7          	jalr	-502(ra) # 63c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 83a:	0992                	slli	s3,s3,0x4
 83c:	397d                	addiw	s2,s2,-1
 83e:	fe0914e3          	bnez	s2,826 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 842:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 846:	4981                	li	s3,0
 848:	b70d                	j	76a <vprintf+0x60>
        s = va_arg(ap, char*);
 84a:	008b0913          	addi	s2,s6,8
 84e:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 852:	02098163          	beqz	s3,874 <vprintf+0x16a>
        while(*s != 0){
 856:	0009c583          	lbu	a1,0(s3)
 85a:	c5ad                	beqz	a1,8c4 <vprintf+0x1ba>
          putc(fd, *s);
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	dde080e7          	jalr	-546(ra) # 63c <putc>
          s++;
 866:	0985                	addi	s3,s3,1
        while(*s != 0){
 868:	0009c583          	lbu	a1,0(s3)
 86c:	f9e5                	bnez	a1,85c <vprintf+0x152>
        s = va_arg(ap, char*);
 86e:	8b4a                	mv	s6,s2
      state = 0;
 870:	4981                	li	s3,0
 872:	bde5                	j	76a <vprintf+0x60>
          s = "(null)";
 874:	00000997          	auipc	s3,0x0
 878:	27c98993          	addi	s3,s3,636 # af0 <malloc+0x122>
        while(*s != 0){
 87c:	85ee                	mv	a1,s11
 87e:	bff9                	j	85c <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 880:	008b0913          	addi	s2,s6,8
 884:	000b4583          	lbu	a1,0(s6)
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	db2080e7          	jalr	-590(ra) # 63c <putc>
 892:	8b4a                	mv	s6,s2
      state = 0;
 894:	4981                	li	s3,0
 896:	bdd1                	j	76a <vprintf+0x60>
        putc(fd, c);
 898:	85d2                	mv	a1,s4
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	da0080e7          	jalr	-608(ra) # 63c <putc>
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b5d1                	j	76a <vprintf+0x60>
        putc(fd, '%');
 8a8:	85d2                	mv	a1,s4
 8aa:	8556                	mv	a0,s5
 8ac:	00000097          	auipc	ra,0x0
 8b0:	d90080e7          	jalr	-624(ra) # 63c <putc>
        putc(fd, c);
 8b4:	85ca                	mv	a1,s2
 8b6:	8556                	mv	a0,s5
 8b8:	00000097          	auipc	ra,0x0
 8bc:	d84080e7          	jalr	-636(ra) # 63c <putc>
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	b565                	j	76a <vprintf+0x60>
        s = va_arg(ap, char*);
 8c4:	8b4a                	mv	s6,s2
      state = 0;
 8c6:	4981                	li	s3,0
 8c8:	b54d                	j	76a <vprintf+0x60>
    }
  }
}
 8ca:	70e6                	ld	ra,120(sp)
 8cc:	7446                	ld	s0,112(sp)
 8ce:	74a6                	ld	s1,104(sp)
 8d0:	7906                	ld	s2,96(sp)
 8d2:	69e6                	ld	s3,88(sp)
 8d4:	6a46                	ld	s4,80(sp)
 8d6:	6aa6                	ld	s5,72(sp)
 8d8:	6b06                	ld	s6,64(sp)
 8da:	7be2                	ld	s7,56(sp)
 8dc:	7c42                	ld	s8,48(sp)
 8de:	7ca2                	ld	s9,40(sp)
 8e0:	7d02                	ld	s10,32(sp)
 8e2:	6de2                	ld	s11,24(sp)
 8e4:	6109                	addi	sp,sp,128
 8e6:	8082                	ret

00000000000008e8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8e8:	715d                	addi	sp,sp,-80
 8ea:	ec06                	sd	ra,24(sp)
 8ec:	e822                	sd	s0,16(sp)
 8ee:	1000                	addi	s0,sp,32
 8f0:	e010                	sd	a2,0(s0)
 8f2:	e414                	sd	a3,8(s0)
 8f4:	e818                	sd	a4,16(s0)
 8f6:	ec1c                	sd	a5,24(s0)
 8f8:	03043023          	sd	a6,32(s0)
 8fc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 900:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 904:	8622                	mv	a2,s0
 906:	00000097          	auipc	ra,0x0
 90a:	e04080e7          	jalr	-508(ra) # 70a <vprintf>
}
 90e:	60e2                	ld	ra,24(sp)
 910:	6442                	ld	s0,16(sp)
 912:	6161                	addi	sp,sp,80
 914:	8082                	ret

0000000000000916 <printf>:

void
printf(const char *fmt, ...)
{
 916:	711d                	addi	sp,sp,-96
 918:	ec06                	sd	ra,24(sp)
 91a:	e822                	sd	s0,16(sp)
 91c:	1000                	addi	s0,sp,32
 91e:	e40c                	sd	a1,8(s0)
 920:	e810                	sd	a2,16(s0)
 922:	ec14                	sd	a3,24(s0)
 924:	f018                	sd	a4,32(s0)
 926:	f41c                	sd	a5,40(s0)
 928:	03043823          	sd	a6,48(s0)
 92c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 930:	00840613          	addi	a2,s0,8
 934:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 938:	85aa                	mv	a1,a0
 93a:	4505                	li	a0,1
 93c:	00000097          	auipc	ra,0x0
 940:	dce080e7          	jalr	-562(ra) # 70a <vprintf>
}
 944:	60e2                	ld	ra,24(sp)
 946:	6442                	ld	s0,16(sp)
 948:	6125                	addi	sp,sp,96
 94a:	8082                	ret

000000000000094c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 94c:	1141                	addi	sp,sp,-16
 94e:	e422                	sd	s0,8(sp)
 950:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 952:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 956:	00000797          	auipc	a5,0x0
 95a:	2127b783          	ld	a5,530(a5) # b68 <freep>
 95e:	a02d                	j	988 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 960:	4618                	lw	a4,8(a2)
 962:	9f2d                	addw	a4,a4,a1
 964:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 968:	6398                	ld	a4,0(a5)
 96a:	6310                	ld	a2,0(a4)
 96c:	a83d                	j	9aa <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 96e:	ff852703          	lw	a4,-8(a0)
 972:	9f31                	addw	a4,a4,a2
 974:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 976:	ff053683          	ld	a3,-16(a0)
 97a:	a091                	j	9be <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97c:	6398                	ld	a4,0(a5)
 97e:	00e7e463          	bltu	a5,a4,986 <free+0x3a>
 982:	00e6ea63          	bltu	a3,a4,996 <free+0x4a>
{
 986:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 988:	fed7fae3          	bgeu	a5,a3,97c <free+0x30>
 98c:	6398                	ld	a4,0(a5)
 98e:	00e6e463          	bltu	a3,a4,996 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 992:	fee7eae3          	bltu	a5,a4,986 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 996:	ff852583          	lw	a1,-8(a0)
 99a:	6390                	ld	a2,0(a5)
 99c:	02059813          	slli	a6,a1,0x20
 9a0:	01c85713          	srli	a4,a6,0x1c
 9a4:	9736                	add	a4,a4,a3
 9a6:	fae60de3          	beq	a2,a4,960 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9aa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ae:	4790                	lw	a2,8(a5)
 9b0:	02061593          	slli	a1,a2,0x20
 9b4:	01c5d713          	srli	a4,a1,0x1c
 9b8:	973e                	add	a4,a4,a5
 9ba:	fae68ae3          	beq	a3,a4,96e <free+0x22>
    p->s.ptr = bp->s.ptr;
 9be:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9c0:	00000717          	auipc	a4,0x0
 9c4:	1af73423          	sd	a5,424(a4) # b68 <freep>
}
 9c8:	6422                	ld	s0,8(sp)
 9ca:	0141                	addi	sp,sp,16
 9cc:	8082                	ret

00000000000009ce <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ce:	7139                	addi	sp,sp,-64
 9d0:	fc06                	sd	ra,56(sp)
 9d2:	f822                	sd	s0,48(sp)
 9d4:	f426                	sd	s1,40(sp)
 9d6:	f04a                	sd	s2,32(sp)
 9d8:	ec4e                	sd	s3,24(sp)
 9da:	e852                	sd	s4,16(sp)
 9dc:	e456                	sd	s5,8(sp)
 9de:	e05a                	sd	s6,0(sp)
 9e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e2:	02051493          	slli	s1,a0,0x20
 9e6:	9081                	srli	s1,s1,0x20
 9e8:	04bd                	addi	s1,s1,15
 9ea:	8091                	srli	s1,s1,0x4
 9ec:	0014899b          	addiw	s3,s1,1
 9f0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9f2:	00000517          	auipc	a0,0x0
 9f6:	17653503          	ld	a0,374(a0) # b68 <freep>
 9fa:	c515                	beqz	a0,a26 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fe:	4798                	lw	a4,8(a5)
 a00:	02977f63          	bgeu	a4,s1,a3e <malloc+0x70>
 a04:	8a4e                	mv	s4,s3
 a06:	0009871b          	sext.w	a4,s3
 a0a:	6685                	lui	a3,0x1
 a0c:	00d77363          	bgeu	a4,a3,a12 <malloc+0x44>
 a10:	6a05                	lui	s4,0x1
 a12:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a16:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a1a:	00000917          	auipc	s2,0x0
 a1e:	14e90913          	addi	s2,s2,334 # b68 <freep>
  if(p == (char*)-1)
 a22:	5afd                	li	s5,-1
 a24:	a895                	j	a98 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a26:	00000797          	auipc	a5,0x0
 a2a:	54a78793          	addi	a5,a5,1354 # f70 <base>
 a2e:	00000717          	auipc	a4,0x0
 a32:	12f73d23          	sd	a5,314(a4) # b68 <freep>
 a36:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a38:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a3c:	b7e1                	j	a04 <malloc+0x36>
      if(p->s.size == nunits)
 a3e:	02e48c63          	beq	s1,a4,a76 <malloc+0xa8>
        p->s.size -= nunits;
 a42:	4137073b          	subw	a4,a4,s3
 a46:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a48:	02071693          	slli	a3,a4,0x20
 a4c:	01c6d713          	srli	a4,a3,0x1c
 a50:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a52:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a56:	00000717          	auipc	a4,0x0
 a5a:	10a73923          	sd	a0,274(a4) # b68 <freep>
      return (void*)(p + 1);
 a5e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a62:	70e2                	ld	ra,56(sp)
 a64:	7442                	ld	s0,48(sp)
 a66:	74a2                	ld	s1,40(sp)
 a68:	7902                	ld	s2,32(sp)
 a6a:	69e2                	ld	s3,24(sp)
 a6c:	6a42                	ld	s4,16(sp)
 a6e:	6aa2                	ld	s5,8(sp)
 a70:	6b02                	ld	s6,0(sp)
 a72:	6121                	addi	sp,sp,64
 a74:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a76:	6398                	ld	a4,0(a5)
 a78:	e118                	sd	a4,0(a0)
 a7a:	bff1                	j	a56 <malloc+0x88>
  hp->s.size = nu;
 a7c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a80:	0541                	addi	a0,a0,16
 a82:	00000097          	auipc	ra,0x0
 a86:	eca080e7          	jalr	-310(ra) # 94c <free>
  return freep;
 a8a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a8e:	d971                	beqz	a0,a62 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a92:	4798                	lw	a4,8(a5)
 a94:	fa9775e3          	bgeu	a4,s1,a3e <malloc+0x70>
    if(p == freep)
 a98:	00093703          	ld	a4,0(s2)
 a9c:	853e                	mv	a0,a5
 a9e:	fef719e3          	bne	a4,a5,a90 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 aa2:	8552                	mv	a0,s4
 aa4:	00000097          	auipc	ra,0x0
 aa8:	b80080e7          	jalr	-1152(ra) # 624 <sbrk>
  if(p == (char*)-1)
 aac:	fd5518e3          	bne	a0,s5,a7c <malloc+0xae>
        return 0;
 ab0:	4501                	li	a0,0
 ab2:	bf45                	j	a62 <malloc+0x94>
