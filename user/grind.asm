
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1d3bc>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x2246>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd58b>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00001517          	auipc	a0,0x1
      64:	70850513          	addi	a0,a0,1800 # 1768 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	e82080e7          	jalr	-382(ra) # f12 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	30e50513          	addi	a0,a0,782 # 13a8 <malloc+0xec>
      a2:	00001097          	auipc	ra,0x1
      a6:	e50080e7          	jalr	-432(ra) # ef2 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	2fe50513          	addi	a0,a0,766 # 13a8 <malloc+0xec>
      b2:	00001097          	auipc	ra,0x1
      b6:	e48080e7          	jalr	-440(ra) # efa <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	2f450513          	addi	a0,a0,756 # 13b0 <malloc+0xf4>
      c4:	00001097          	auipc	ra,0x1
      c8:	140080e7          	jalr	320(ra) # 1204 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	dbc080e7          	jalr	-580(ra) # e8a <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	2fa50513          	addi	a0,a0,762 # 13d0 <malloc+0x114>
      de:	00001097          	auipc	ra,0x1
      e2:	e1c080e7          	jalr	-484(ra) # efa <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e6:	00001997          	auipc	s3,0x1
      ea:	2fa98993          	addi	s3,s3,762 # 13e0 <malloc+0x124>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	2e898993          	addi	s3,s3,744 # 13d8 <malloc+0x11c>
    iters++;
      f8:	4485                	li	s1,1
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00001917          	auipc	s2,0x1
     100:	59490913          	addi	s2,s2,1428 # 1690 <malloc+0x3d4>
     104:	a825                	j	13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	2de50513          	addi	a0,a0,734 # 13e8 <malloc+0x12c>
     112:	00001097          	auipc	ra,0x1
     116:	db8080e7          	jalr	-584(ra) # eca <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	d98080e7          	jalr	-616(ra) # eb2 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	d76080e7          	jalr	-650(ra) # eaa <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	47d9                	li	a5,22
     152:	fca7e8e3          	bltu	a5,a0,122 <go+0xaa>
     156:	050a                	slli	a0,a0,0x2
     158:	954a                	add	a0,a0,s2
     15a:	411c                	lw	a5,0(a0)
     15c:	97ca                	add	a5,a5,s2
     15e:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     160:	20200593          	li	a1,514
     164:	00001517          	auipc	a0,0x1
     168:	29450513          	addi	a0,a0,660 # 13f8 <malloc+0x13c>
     16c:	00001097          	auipc	ra,0x1
     170:	d5e080e7          	jalr	-674(ra) # eca <open>
     174:	00001097          	auipc	ra,0x1
     178:	d3e080e7          	jalr	-706(ra) # eb2 <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	26a50513          	addi	a0,a0,618 # 13e8 <malloc+0x12c>
     186:	00001097          	auipc	ra,0x1
     18a:	d54080e7          	jalr	-684(ra) # eda <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	21850513          	addi	a0,a0,536 # 13a8 <malloc+0xec>
     198:	00001097          	auipc	ra,0x1
     19c:	d62080e7          	jalr	-670(ra) # efa <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	26e50513          	addi	a0,a0,622 # 1410 <malloc+0x154>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	d30080e7          	jalr	-720(ra) # eda <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	21e50513          	addi	a0,a0,542 # 13d0 <malloc+0x114>
     1ba:	00001097          	auipc	ra,0x1
     1be:	d40080e7          	jalr	-704(ra) # efa <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	1ec50513          	addi	a0,a0,492 # 13b0 <malloc+0xf4>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	038080e7          	jalr	56(ra) # 1204 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	cb4080e7          	jalr	-844(ra) # e8a <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	cd2080e7          	jalr	-814(ra) # eb2 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	22c50513          	addi	a0,a0,556 # 1418 <malloc+0x15c>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	cd6080e7          	jalr	-810(ra) # eca <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	cb0080e7          	jalr	-848(ra) # eb2 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	21a50513          	addi	a0,a0,538 # 1428 <malloc+0x16c>
     216:	00001097          	auipc	ra,0x1
     21a:	cb4080e7          	jalr	-844(ra) # eca <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00001597          	auipc	a1,0x1
     22a:	55258593          	addi	a1,a1,1362 # 1778 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	c7a080e7          	jalr	-902(ra) # eaa <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00001597          	auipc	a1,0x1
     242:	53a58593          	addi	a1,a1,1338 # 1778 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	c5a080e7          	jalr	-934(ra) # ea2 <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	19650513          	addi	a0,a0,406 # 13e8 <malloc+0x12c>
     25a:	00001097          	auipc	ra,0x1
     25e:	c98080e7          	jalr	-872(ra) # ef2 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	1da50513          	addi	a0,a0,474 # 1440 <malloc+0x184>
     26e:	00001097          	auipc	ra,0x1
     272:	c5c080e7          	jalr	-932(ra) # eca <open>
     276:	00001097          	auipc	ra,0x1
     27a:	c3c080e7          	jalr	-964(ra) # eb2 <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	1d250513          	addi	a0,a0,466 # 1450 <malloc+0x194>
     286:	00001097          	auipc	ra,0x1
     28a:	c54080e7          	jalr	-940(ra) # eda <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	1c850513          	addi	a0,a0,456 # 1458 <malloc+0x19c>
     298:	00001097          	auipc	ra,0x1
     29c:	c5a080e7          	jalr	-934(ra) # ef2 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	1bc50513          	addi	a0,a0,444 # 1460 <malloc+0x1a4>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	c1e080e7          	jalr	-994(ra) # eca <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	bfe080e7          	jalr	-1026(ra) # eb2 <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	1b450513          	addi	a0,a0,436 # 1470 <malloc+0x1b4>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	c16080e7          	jalr	-1002(ra) # eda <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	16a50513          	addi	a0,a0,362 # 1438 <malloc+0x17c>
     2d6:	00001097          	auipc	ra,0x1
     2da:	c04080e7          	jalr	-1020(ra) # eda <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	13258593          	addi	a1,a1,306 # 1410 <malloc+0x154>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	19250513          	addi	a0,a0,402 # 1478 <malloc+0x1bc>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	bfc080e7          	jalr	-1028(ra) # eea <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	19850513          	addi	a0,a0,408 # 1490 <malloc+0x1d4>
     300:	00001097          	auipc	ra,0x1
     304:	bda080e7          	jalr	-1062(ra) # eda <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	11058593          	addi	a1,a1,272 # 1418 <malloc+0x15c>
     310:	00001517          	auipc	a0,0x1
     314:	19050513          	addi	a0,a0,400 # 14a0 <malloc+0x1e4>
     318:	00001097          	auipc	ra,0x1
     31c:	bd2080e7          	jalr	-1070(ra) # eea <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	b60080e7          	jalr	-1184(ra) # e82 <fork>
      if(pid == 0){
     32a:	c909                	beqz	a0,33c <go+0x2c4>
        exit(0);
      } else if(pid < 0){
     32c:	00054c63          	bltz	a0,344 <go+0x2cc>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     330:	4501                	li	a0,0
     332:	00001097          	auipc	ra,0x1
     336:	b60080e7          	jalr	-1184(ra) # e92 <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	b4e080e7          	jalr	-1202(ra) # e8a <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	16450513          	addi	a0,a0,356 # 14a8 <malloc+0x1ec>
     34c:	00001097          	auipc	ra,0x1
     350:	eb8080e7          	jalr	-328(ra) # 1204 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	b34080e7          	jalr	-1228(ra) # e8a <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	b24080e7          	jalr	-1244(ra) # e82 <fork>
      if(pid == 0){
     366:	c909                	beqz	a0,378 <go+0x300>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     368:	02054563          	bltz	a0,392 <go+0x31a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	b24080e7          	jalr	-1244(ra) # e92 <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	b0a080e7          	jalr	-1270(ra) # e82 <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	b02080e7          	jalr	-1278(ra) # e82 <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	b00080e7          	jalr	-1280(ra) # e8a <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	11650513          	addi	a0,a0,278 # 14a8 <malloc+0x1ec>
     39a:	00001097          	auipc	ra,0x1
     39e:	e6a080e7          	jalr	-406(ra) # 1204 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	ae6080e7          	jalr	-1306(ra) # e8a <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	addi	a0,a0,1915 # 177b <buf.0+0x3>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	b60080e7          	jalr	-1184(ra) # f12 <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	b54080e7          	jalr	-1196(ra) # f12 <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	b46080e7          	jalr	-1210(ra) # f12 <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	b3a080e7          	jalr	-1222(ra) # f12 <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	aa0080e7          	jalr	-1376(ra) # e82 <fork>
     3ea:	8b2a                	mv	s6,a0
      if(pid == 0){
     3ec:	c51d                	beqz	a0,41a <go+0x3a2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3ee:	04054963          	bltz	a0,440 <go+0x3c8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3f2:	00001517          	auipc	a0,0x1
     3f6:	0ce50513          	addi	a0,a0,206 # 14c0 <malloc+0x204>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	b00080e7          	jalr	-1280(ra) # efa <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	ab4080e7          	jalr	-1356(ra) # eba <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	a82080e7          	jalr	-1406(ra) # e92 <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	06a50513          	addi	a0,a0,106 # 1488 <malloc+0x1cc>
     426:	00001097          	auipc	ra,0x1
     42a:	aa4080e7          	jalr	-1372(ra) # eca <open>
     42e:	00001097          	auipc	ra,0x1
     432:	a84080e7          	jalr	-1404(ra) # eb2 <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	a52080e7          	jalr	-1454(ra) # e8a <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	06850513          	addi	a0,a0,104 # 14a8 <malloc+0x1ec>
     448:	00001097          	auipc	ra,0x1
     44c:	dbc080e7          	jalr	-580(ra) # 1204 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	a38080e7          	jalr	-1480(ra) # e8a <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	07650513          	addi	a0,a0,118 # 14d0 <malloc+0x214>
     462:	00001097          	auipc	ra,0x1
     466:	da2080e7          	jalr	-606(ra) # 1204 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	a1e080e7          	jalr	-1506(ra) # e8a <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	a0e080e7          	jalr	-1522(ra) # e82 <fork>
      if(pid == 0){
     47c:	c909                	beqz	a0,48e <go+0x416>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     47e:	02054563          	bltz	a0,4a8 <go+0x430>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     482:	4501                	li	a0,0
     484:	00001097          	auipc	ra,0x1
     488:	a0e080e7          	jalr	-1522(ra) # e92 <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	a7c080e7          	jalr	-1412(ra) # f0a <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	a24080e7          	jalr	-1500(ra) # eba <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	9ea080e7          	jalr	-1558(ra) # e8a <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	00050513          	mv	a0,a0
     4b0:	00001097          	auipc	ra,0x1
     4b4:	d54080e7          	jalr	-684(ra) # 1204 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	9d0080e7          	jalr	-1584(ra) # e8a <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	addi	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	9d4080e7          	jalr	-1580(ra) # e9a <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	9b0080e7          	jalr	-1616(ra) # e82 <fork>
      if(pid == 0){
     4da:	c131                	beqz	a0,51e <go+0x4a6>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4dc:	0a054a63          	bltz	a0,590 <go+0x518>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4e0:	fa842503          	lw	a0,-88(s0)
     4e4:	00001097          	auipc	ra,0x1
     4e8:	9ce080e7          	jalr	-1586(ra) # eb2 <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	9c2080e7          	jalr	-1598(ra) # eb2 <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	998080e7          	jalr	-1640(ra) # e92 <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	fe450513          	addi	a0,a0,-28 # 14e8 <malloc+0x22c>
     50c:	00001097          	auipc	ra,0x1
     510:	cf8080e7          	jalr	-776(ra) # 1204 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	974080e7          	jalr	-1676(ra) # e8a <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	964080e7          	jalr	-1692(ra) # e82 <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	95c080e7          	jalr	-1700(ra) # e82 <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	fd058593          	addi	a1,a1,-48 # 1500 <malloc+0x244>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	96e080e7          	jalr	-1682(ra) # eaa <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	addi	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	94e080e7          	jalr	-1714(ra) # ea2 <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	926080e7          	jalr	-1754(ra) # e8a <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	f9c50513          	addi	a0,a0,-100 # 1508 <malloc+0x24c>
     574:	00001097          	auipc	ra,0x1
     578:	c90080e7          	jalr	-880(ra) # 1204 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	faa50513          	addi	a0,a0,-86 # 1528 <malloc+0x26c>
     586:	00001097          	auipc	ra,0x1
     58a:	c7e080e7          	jalr	-898(ra) # 1204 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	f1850513          	addi	a0,a0,-232 # 14a8 <malloc+0x1ec>
     598:	00001097          	auipc	ra,0x1
     59c:	c6c080e7          	jalr	-916(ra) # 1204 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	8e8080e7          	jalr	-1816(ra) # e8a <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	8d8080e7          	jalr	-1832(ra) # e82 <fork>
      if(pid == 0){
     5b2:	c909                	beqz	a0,5c4 <go+0x54c>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5b4:	06054f63          	bltz	a0,632 <go+0x5ba>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5b8:	4501                	li	a0,0
     5ba:	00001097          	auipc	ra,0x1
     5be:	8d8080e7          	jalr	-1832(ra) # e92 <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	ec450513          	addi	a0,a0,-316 # 1488 <malloc+0x1cc>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	90e080e7          	jalr	-1778(ra) # eda <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	eb450513          	addi	a0,a0,-332 # 1488 <malloc+0x1cc>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	916080e7          	jalr	-1770(ra) # ef2 <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	ea450513          	addi	a0,a0,-348 # 1488 <malloc+0x1cc>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	90e080e7          	jalr	-1778(ra) # efa <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	dfc50513          	addi	a0,a0,-516 # 13f0 <malloc+0x134>
     5fc:	00001097          	auipc	ra,0x1
     600:	8de080e7          	jalr	-1826(ra) # eda <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	ef850513          	addi	a0,a0,-264 # 1500 <malloc+0x244>
     610:	00001097          	auipc	ra,0x1
     614:	8ba080e7          	jalr	-1862(ra) # eca <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	ee850513          	addi	a0,a0,-280 # 1500 <malloc+0x244>
     620:	00001097          	auipc	ra,0x1
     624:	8ba080e7          	jalr	-1862(ra) # eda <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	860080e7          	jalr	-1952(ra) # e8a <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	e7650513          	addi	a0,a0,-394 # 14a8 <malloc+0x1ec>
     63a:	00001097          	auipc	ra,0x1
     63e:	bca080e7          	jalr	-1078(ra) # 1204 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	846080e7          	jalr	-1978(ra) # e8a <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	efc50513          	addi	a0,a0,-260 # 1548 <malloc+0x28c>
     654:	00001097          	auipc	ra,0x1
     658:	886080e7          	jalr	-1914(ra) # eda <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	ee850513          	addi	a0,a0,-280 # 1548 <malloc+0x28c>
     668:	00001097          	auipc	ra,0x1
     66c:	862080e7          	jalr	-1950(ra) # eca <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	e8858593          	addi	a1,a1,-376 # 1500 <malloc+0x244>
     680:	00001097          	auipc	ra,0x1
     684:	82a080e7          	jalr	-2006(ra) # eaa <write>
     688:	4785                	li	a5,1
     68a:	06f51063          	bne	a0,a5,6ea <go+0x672>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     68e:	fa840593          	addi	a1,s0,-88
     692:	855a                	mv	a0,s6
     694:	00001097          	auipc	ra,0x1
     698:	84e080e7          	jalr	-1970(ra) # ee2 <fstat>
     69c:	e525                	bnez	a0,704 <go+0x68c>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     69e:	fb843583          	ld	a1,-72(s0)
     6a2:	4785                	li	a5,1
     6a4:	06f59d63          	bne	a1,a5,71e <go+0x6a6>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6a8:	fac42583          	lw	a1,-84(s0)
     6ac:	0c800793          	li	a5,200
     6b0:	08b7e563          	bltu	a5,a1,73a <go+0x6c2>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6b4:	855a                	mv	a0,s6
     6b6:	00000097          	auipc	ra,0x0
     6ba:	7fc080e7          	jalr	2044(ra) # eb2 <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	e8a50513          	addi	a0,a0,-374 # 1548 <malloc+0x28c>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	814080e7          	jalr	-2028(ra) # eda <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	e8050513          	addi	a0,a0,-384 # 1550 <malloc+0x294>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	b2c080e7          	jalr	-1236(ra) # 1204 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00000097          	auipc	ra,0x0
     6e6:	7a8080e7          	jalr	1960(ra) # e8a <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	e7e50513          	addi	a0,a0,-386 # 1568 <malloc+0x2ac>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	b12080e7          	jalr	-1262(ra) # 1204 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00000097          	auipc	ra,0x0
     700:	78e080e7          	jalr	1934(ra) # e8a <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	e7c50513          	addi	a0,a0,-388 # 1580 <malloc+0x2c4>
     70c:	00001097          	auipc	ra,0x1
     710:	af8080e7          	jalr	-1288(ra) # 1204 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00000097          	auipc	ra,0x0
     71a:	774080e7          	jalr	1908(ra) # e8a <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	e7850513          	addi	a0,a0,-392 # 1598 <malloc+0x2dc>
     728:	00001097          	auipc	ra,0x1
     72c:	adc080e7          	jalr	-1316(ra) # 1204 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00000097          	auipc	ra,0x0
     736:	758080e7          	jalr	1880(ra) # e8a <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	e8650513          	addi	a0,a0,-378 # 15c0 <malloc+0x304>
     742:	00001097          	auipc	ra,0x1
     746:	ac2080e7          	jalr	-1342(ra) # 1204 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00000097          	auipc	ra,0x0
     750:	73e080e7          	jalr	1854(ra) # e8a <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	addi	a0,s0,-104
     758:	00000097          	auipc	ra,0x0
     75c:	742080e7          	jalr	1858(ra) # e9a <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	addi	a0,s0,-96
     768:	00000097          	auipc	ra,0x0
     76c:	732080e7          	jalr	1842(ra) # e9a <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00000097          	auipc	ra,0x0
     778:	70e080e7          	jalr	1806(ra) # e82 <fork>
      if(pid1 == 0){
     77c:	10050e63          	beqz	a0,898 <go+0x820>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     780:	1c054663          	bltz	a0,94c <go+0x8d4>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     784:	00000097          	auipc	ra,0x0
     788:	6fe080e7          	jalr	1790(ra) # e82 <fork>
      if(pid2 == 0){
     78c:	1c050e63          	beqz	a0,968 <go+0x8f0>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     790:	2a054a63          	bltz	a0,a44 <go+0x9cc>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     794:	f9842503          	lw	a0,-104(s0)
     798:	00000097          	auipc	ra,0x0
     79c:	71a080e7          	jalr	1818(ra) # eb2 <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00000097          	auipc	ra,0x0
     7a8:	70e080e7          	jalr	1806(ra) # eb2 <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00000097          	auipc	ra,0x0
     7b4:	702080e7          	jalr	1794(ra) # eb2 <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	addi	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00000097          	auipc	ra,0x0
     7ca:	6dc080e7          	jalr	1756(ra) # ea2 <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	addi	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00000097          	auipc	ra,0x0
     7dc:	6ca080e7          	jalr	1738(ra) # ea2 <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	addi	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00000097          	auipc	ra,0x0
     7ee:	6b8080e7          	jalr	1720(ra) # ea2 <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00000097          	auipc	ra,0x0
     7fa:	6bc080e7          	jalr	1724(ra) # eb2 <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	addi	a0,s0,-108
     802:	00000097          	auipc	ra,0x0
     806:	690080e7          	jalr	1680(ra) # e92 <wait>
      wait(&st2);
     80a:	fa840513          	addi	a0,s0,-88
     80e:	00000097          	auipc	ra,0x0
     812:	684080e7          	jalr	1668(ra) # e92 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	e3e58593          	addi	a1,a1,-450 # 1660 <malloc+0x3a4>
     82a:	f9040513          	addi	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	37a080e7          	jalr	890(ra) # ba8 <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	addi	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	e2250513          	addi	a0,a0,-478 # 1668 <malloc+0x3ac>
     84e:	00001097          	auipc	ra,0x1
     852:	9b6080e7          	jalr	-1610(ra) # 1204 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00000097          	auipc	ra,0x0
     85c:	632080e7          	jalr	1586(ra) # e8a <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	c8858593          	addi	a1,a1,-888 # 14e8 <malloc+0x22c>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	96c080e7          	jalr	-1684(ra) # 11d6 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00000097          	auipc	ra,0x0
     878:	616080e7          	jalr	1558(ra) # e8a <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	c6c58593          	addi	a1,a1,-916 # 14e8 <malloc+0x22c>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	950080e7          	jalr	-1712(ra) # 11d6 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	5fa080e7          	jalr	1530(ra) # e8a <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00000097          	auipc	ra,0x0
     8a0:	616080e7          	jalr	1558(ra) # eb2 <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00000097          	auipc	ra,0x0
     8ac:	60a080e7          	jalr	1546(ra) # eb2 <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00000097          	auipc	ra,0x0
     8b8:	5fe080e7          	jalr	1534(ra) # eb2 <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	5f4080e7          	jalr	1524(ra) # eb2 <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00000097          	auipc	ra,0x0
     8ce:	638080e7          	jalr	1592(ra) # f02 <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	d1058593          	addi	a1,a1,-752 # 15e8 <malloc+0x32c>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	8f4080e7          	jalr	-1804(ra) # 11d6 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	59e080e7          	jalr	1438(ra) # e8a <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00000097          	auipc	ra,0x0
     8fc:	5ba080e7          	jalr	1466(ra) # eb2 <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	d0078793          	addi	a5,a5,-768 # 1600 <malloc+0x344>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	cfc78793          	addi	a5,a5,-772 # 1608 <malloc+0x34c>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	addi	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	cf050513          	addi	a0,a0,-784 # 1610 <malloc+0x354>
     928:	00000097          	auipc	ra,0x0
     92c:	59a080e7          	jalr	1434(ra) # ec2 <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	cf058593          	addi	a1,a1,-784 # 1620 <malloc+0x364>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	89c080e7          	jalr	-1892(ra) # 11d6 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00000097          	auipc	ra,0x0
     948:	546080e7          	jalr	1350(ra) # e8a <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	b5c58593          	addi	a1,a1,-1188 # 14a8 <malloc+0x1ec>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	880080e7          	jalr	-1920(ra) # 11d6 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00000097          	auipc	ra,0x0
     964:	52a080e7          	jalr	1322(ra) # e8a <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	546080e7          	jalr	1350(ra) # eb2 <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00000097          	auipc	ra,0x0
     97c:	53a080e7          	jalr	1338(ra) # eb2 <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00000097          	auipc	ra,0x0
     986:	530080e7          	jalr	1328(ra) # eb2 <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00000097          	auipc	ra,0x0
     992:	574080e7          	jalr	1396(ra) # f02 <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	c5058593          	addi	a1,a1,-944 # 15e8 <malloc+0x32c>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	834080e7          	jalr	-1996(ra) # 11d6 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00000097          	auipc	ra,0x0
     9b0:	4de080e7          	jalr	1246(ra) # e8a <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	4fa080e7          	jalr	1274(ra) # eb2 <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	4f0080e7          	jalr	1264(ra) # eb2 <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	534080e7          	jalr	1332(ra) # f02 <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	c0c58593          	addi	a1,a1,-1012 # 15e8 <malloc+0x32c>
     9e4:	4509                	li	a0,2
     9e6:	00000097          	auipc	ra,0x0
     9ea:	7f0080e7          	jalr	2032(ra) # 11d6 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	49a080e7          	jalr	1178(ra) # e8a <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00000097          	auipc	ra,0x0
     a00:	4b6080e7          	jalr	1206(ra) # eb2 <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	c3478793          	addi	a5,a5,-972 # 1638 <malloc+0x37c>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	addi	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	c2850513          	addi	a0,a0,-984 # 1640 <malloc+0x384>
     a20:	00000097          	auipc	ra,0x0
     a24:	4a2080e7          	jalr	1186(ra) # ec2 <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	c2058593          	addi	a1,a1,-992 # 1648 <malloc+0x38c>
     a30:	4509                	li	a0,2
     a32:	00000097          	auipc	ra,0x0
     a36:	7a4080e7          	jalr	1956(ra) # 11d6 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	44e080e7          	jalr	1102(ra) # e8a <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	a6458593          	addi	a1,a1,-1436 # 14a8 <malloc+0x1ec>
     a4c:	4509                	li	a0,2
     a4e:	00000097          	auipc	ra,0x0
     a52:	788080e7          	jalr	1928(ra) # 11d6 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	432080e7          	jalr	1074(ra) # e8a <exit>

0000000000000a60 <iter>:
  }
}

void
iter()
{
     a60:	7179                	addi	sp,sp,-48
     a62:	f406                	sd	ra,40(sp)
     a64:	f022                	sd	s0,32(sp)
     a66:	ec26                	sd	s1,24(sp)
     a68:	e84a                	sd	s2,16(sp)
     a6a:	1800                	addi	s0,sp,48
  unlink("a");
     a6c:	00001517          	auipc	a0,0x1
     a70:	a1c50513          	addi	a0,a0,-1508 # 1488 <malloc+0x1cc>
     a74:	00000097          	auipc	ra,0x0
     a78:	466080e7          	jalr	1126(ra) # eda <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	9bc50513          	addi	a0,a0,-1604 # 1438 <malloc+0x17c>
     a84:	00000097          	auipc	ra,0x0
     a88:	456080e7          	jalr	1110(ra) # eda <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	3f6080e7          	jalr	1014(ra) # e82 <fork>
  if(pid1 < 0){
     a94:	00054e63          	bltz	a0,ab0 <iter+0x50>
     a98:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a9a:	e905                	bnez	a0,aca <iter+0x6a>
    rand_next = 31;
     a9c:	47fd                	li	a5,31
     a9e:	00001717          	auipc	a4,0x1
     aa2:	ccf73523          	sd	a5,-822(a4) # 1768 <rand_next>
    go(0);
     aa6:	4501                	li	a0,0
     aa8:	fffff097          	auipc	ra,0xfffff
     aac:	5d0080e7          	jalr	1488(ra) # 78 <go>
    printf("grind: fork failed\n");
     ab0:	00001517          	auipc	a0,0x1
     ab4:	9f850513          	addi	a0,a0,-1544 # 14a8 <malloc+0x1ec>
     ab8:	00000097          	auipc	ra,0x0
     abc:	74c080e7          	jalr	1868(ra) # 1204 <printf>
    exit(1);
     ac0:	4505                	li	a0,1
     ac2:	00000097          	auipc	ra,0x0
     ac6:	3c8080e7          	jalr	968(ra) # e8a <exit>
    exit(0);
  }

  int pid2 = fork();
     aca:	00000097          	auipc	ra,0x0
     ace:	3b8080e7          	jalr	952(ra) # e82 <fork>
     ad2:	892a                	mv	s2,a0
  if(pid2 < 0){
     ad4:	00054f63          	bltz	a0,af2 <iter+0x92>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     ad8:	e915                	bnez	a0,b0c <iter+0xac>
    rand_next = 7177;
     ada:	6789                	lui	a5,0x2
     adc:	c0978793          	addi	a5,a5,-1015 # 1c09 <__BSS_END__+0x99>
     ae0:	00001717          	auipc	a4,0x1
     ae4:	c8f73423          	sd	a5,-888(a4) # 1768 <rand_next>
    go(1);
     ae8:	4505                	li	a0,1
     aea:	fffff097          	auipc	ra,0xfffff
     aee:	58e080e7          	jalr	1422(ra) # 78 <go>
    printf("grind: fork failed\n");
     af2:	00001517          	auipc	a0,0x1
     af6:	9b650513          	addi	a0,a0,-1610 # 14a8 <malloc+0x1ec>
     afa:	00000097          	auipc	ra,0x0
     afe:	70a080e7          	jalr	1802(ra) # 1204 <printf>
    exit(1);
     b02:	4505                	li	a0,1
     b04:	00000097          	auipc	ra,0x0
     b08:	386080e7          	jalr	902(ra) # e8a <exit>
    exit(0);
  }

  int st1 = -1;
     b0c:	57fd                	li	a5,-1
     b0e:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b12:	fdc40513          	addi	a0,s0,-36
     b16:	00000097          	auipc	ra,0x0
     b1a:	37c080e7          	jalr	892(ra) # e92 <wait>
  if(st1 != 0){
     b1e:	fdc42783          	lw	a5,-36(s0)
     b22:	ef99                	bnez	a5,b40 <iter+0xe0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b24:	57fd                	li	a5,-1
     b26:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b2a:	fd840513          	addi	a0,s0,-40
     b2e:	00000097          	auipc	ra,0x0
     b32:	364080e7          	jalr	868(ra) # e92 <wait>

  exit(0);
     b36:	4501                	li	a0,0
     b38:	00000097          	auipc	ra,0x0
     b3c:	352080e7          	jalr	850(ra) # e8a <exit>
    kill(pid1);
     b40:	8526                	mv	a0,s1
     b42:	00000097          	auipc	ra,0x0
     b46:	378080e7          	jalr	888(ra) # eba <kill>
    kill(pid2);
     b4a:	854a                	mv	a0,s2
     b4c:	00000097          	auipc	ra,0x0
     b50:	36e080e7          	jalr	878(ra) # eba <kill>
     b54:	bfc1                	j	b24 <iter+0xc4>

0000000000000b56 <main>:
}

int
main()
{
     b56:	1141                	addi	sp,sp,-16
     b58:	e406                	sd	ra,8(sp)
     b5a:	e022                	sd	s0,0(sp)
     b5c:	0800                	addi	s0,sp,16
     b5e:	a811                	j	b72 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     b60:	00000097          	auipc	ra,0x0
     b64:	f00080e7          	jalr	-256(ra) # a60 <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     b68:	4551                	li	a0,20
     b6a:	00000097          	auipc	ra,0x0
     b6e:	3b0080e7          	jalr	944(ra) # f1a <sleep>
    int pid = fork();
     b72:	00000097          	auipc	ra,0x0
     b76:	310080e7          	jalr	784(ra) # e82 <fork>
    if(pid == 0){
     b7a:	d17d                	beqz	a0,b60 <main+0xa>
    if(pid > 0){
     b7c:	fea056e3          	blez	a0,b68 <main+0x12>
      wait(0);
     b80:	4501                	li	a0,0
     b82:	00000097          	auipc	ra,0x0
     b86:	310080e7          	jalr	784(ra) # e92 <wait>
     b8a:	bff9                	j	b68 <main+0x12>

0000000000000b8c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b8c:	1141                	addi	sp,sp,-16
     b8e:	e422                	sd	s0,8(sp)
     b90:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b92:	87aa                	mv	a5,a0
     b94:	0585                	addi	a1,a1,1
     b96:	0785                	addi	a5,a5,1
     b98:	fff5c703          	lbu	a4,-1(a1)
     b9c:	fee78fa3          	sb	a4,-1(a5)
     ba0:	fb75                	bnez	a4,b94 <strcpy+0x8>
    ;
  return os;
}
     ba2:	6422                	ld	s0,8(sp)
     ba4:	0141                	addi	sp,sp,16
     ba6:	8082                	ret

0000000000000ba8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ba8:	1141                	addi	sp,sp,-16
     baa:	e422                	sd	s0,8(sp)
     bac:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     bae:	00054783          	lbu	a5,0(a0)
     bb2:	cb91                	beqz	a5,bc6 <strcmp+0x1e>
     bb4:	0005c703          	lbu	a4,0(a1)
     bb8:	00f71763          	bne	a4,a5,bc6 <strcmp+0x1e>
    p++, q++;
     bbc:	0505                	addi	a0,a0,1
     bbe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bc0:	00054783          	lbu	a5,0(a0)
     bc4:	fbe5                	bnez	a5,bb4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bc6:	0005c503          	lbu	a0,0(a1)
}
     bca:	40a7853b          	subw	a0,a5,a0
     bce:	6422                	ld	s0,8(sp)
     bd0:	0141                	addi	sp,sp,16
     bd2:	8082                	ret

0000000000000bd4 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
     bd4:	1141                	addi	sp,sp,-16
     bd6:	e422                	sd	s0,8(sp)
     bd8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bda:	00054783          	lbu	a5,0(a0)
     bde:	cf91                	beqz	a5,bfa <strlen+0x26>
     be0:	0505                	addi	a0,a0,1
     be2:	87aa                	mv	a5,a0
     be4:	4685                	li	a3,1
     be6:	9e89                	subw	a3,a3,a0
     be8:	00f6853b          	addw	a0,a3,a5
     bec:	0785                	addi	a5,a5,1
     bee:	fff7c703          	lbu	a4,-1(a5)
     bf2:	fb7d                	bnez	a4,be8 <strlen+0x14>
    ;
  return n;
}
     bf4:	6422                	ld	s0,8(sp)
     bf6:	0141                	addi	sp,sp,16
     bf8:	8082                	ret
  for(n = 0; s[n]; n++)
     bfa:	4501                	li	a0,0
     bfc:	bfe5                	j	bf4 <strlen+0x20>

0000000000000bfe <strsub>:
int strsub(const char *s, const char *sub){
     bfe:	7139                	addi	sp,sp,-64
     c00:	fc06                	sd	ra,56(sp)
     c02:	f822                	sd	s0,48(sp)
     c04:	f426                	sd	s1,40(sp)
     c06:	f04a                	sd	s2,32(sp)
     c08:	ec4e                	sd	s3,24(sp)
     c0a:	e852                	sd	s4,16(sp)
     c0c:	e456                	sd	s5,8(sp)
     c0e:	0080                	addi	s0,sp,64
     c10:	8a2a                	mv	s4,a0
     c12:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
     c14:	84aa                	mv	s1,a0
     c16:	4901                	li	s2,0
     c18:	a019                	j	c1e <strsub+0x20>
     c1a:	2905                	addiw	s2,s2,1
     c1c:	0485                	addi	s1,s1,1
     c1e:	8552                	mv	a0,s4
     c20:	00000097          	auipc	ra,0x0
     c24:	fb4080e7          	jalr	-76(ra) # bd4 <strlen>
     c28:	2501                	sext.w	a0,a0
     c2a:	04a97863          	bgeu	s2,a0,c7a <strsub+0x7c>
    if(s[i] == sub[0]){
     c2e:	8aa6                	mv	s5,s1
     c30:	0004c703          	lbu	a4,0(s1)
     c34:	0009c783          	lbu	a5,0(s3)
     c38:	fef711e3          	bne	a4,a5,c1a <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
     c3c:	854e                	mv	a0,s3
     c3e:	00000097          	auipc	ra,0x0
     c42:	f96080e7          	jalr	-106(ra) # bd4 <strlen>
     c46:	0005059b          	sext.w	a1,a0
     c4a:	ffe5061b          	addiw	a2,a0,-2
     c4e:	1602                	slli	a2,a2,0x20
     c50:	9201                	srli	a2,a2,0x20
     c52:	0609                	addi	a2,a2,2
     c54:	4785                	li	a5,1
     c56:	0007871b          	sext.w	a4,a5
     c5a:	fcb770e3          	bgeu	a4,a1,c1a <strsub+0x1c>
        if(s[j+i] != sub[j]){
     c5e:	00fa86b3          	add	a3,s5,a5
     c62:	00f98733          	add	a4,s3,a5
     c66:	0006c683          	lbu	a3,0(a3)
     c6a:	00074703          	lbu	a4,0(a4)
     c6e:	fae696e3          	bne	a3,a4,c1a <strsub+0x1c>
        if(j == strlen(sub) -1){
     c72:	0785                	addi	a5,a5,1
     c74:	fec791e3          	bne	a5,a2,c56 <strsub+0x58>
     c78:	a011                	j	c7c <strsub+0x7e>
  return -1;
     c7a:	597d                	li	s2,-1
}
     c7c:	854a                	mv	a0,s2
     c7e:	70e2                	ld	ra,56(sp)
     c80:	7442                	ld	s0,48(sp)
     c82:	74a2                	ld	s1,40(sp)
     c84:	7902                	ld	s2,32(sp)
     c86:	69e2                	ld	s3,24(sp)
     c88:	6a42                	ld	s4,16(sp)
     c8a:	6aa2                	ld	s5,8(sp)
     c8c:	6121                	addi	sp,sp,64
     c8e:	8082                	ret

0000000000000c90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c90:	1141                	addi	sp,sp,-16
     c92:	e422                	sd	s0,8(sp)
     c94:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c96:	ca19                	beqz	a2,cac <memset+0x1c>
     c98:	87aa                	mv	a5,a0
     c9a:	1602                	slli	a2,a2,0x20
     c9c:	9201                	srli	a2,a2,0x20
     c9e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     ca2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     ca6:	0785                	addi	a5,a5,1
     ca8:	fee79de3          	bne	a5,a4,ca2 <memset+0x12>
  }
  return dst;
}
     cac:	6422                	ld	s0,8(sp)
     cae:	0141                	addi	sp,sp,16
     cb0:	8082                	ret

0000000000000cb2 <strchr>:

char*
strchr(const char *s, char c)
{
     cb2:	1141                	addi	sp,sp,-16
     cb4:	e422                	sd	s0,8(sp)
     cb6:	0800                	addi	s0,sp,16
  for(; *s; s++)
     cb8:	00054783          	lbu	a5,0(a0)
     cbc:	cb99                	beqz	a5,cd2 <strchr+0x20>
    if(*s == c)
     cbe:	00f58763          	beq	a1,a5,ccc <strchr+0x1a>
  for(; *s; s++)
     cc2:	0505                	addi	a0,a0,1
     cc4:	00054783          	lbu	a5,0(a0)
     cc8:	fbfd                	bnez	a5,cbe <strchr+0xc>
      return (char*)s;
  return 0;
     cca:	4501                	li	a0,0
}
     ccc:	6422                	ld	s0,8(sp)
     cce:	0141                	addi	sp,sp,16
     cd0:	8082                	ret
  return 0;
     cd2:	4501                	li	a0,0
     cd4:	bfe5                	j	ccc <strchr+0x1a>

0000000000000cd6 <gets>:

char*
gets(char *buf, int max)
{
     cd6:	711d                	addi	sp,sp,-96
     cd8:	ec86                	sd	ra,88(sp)
     cda:	e8a2                	sd	s0,80(sp)
     cdc:	e4a6                	sd	s1,72(sp)
     cde:	e0ca                	sd	s2,64(sp)
     ce0:	fc4e                	sd	s3,56(sp)
     ce2:	f852                	sd	s4,48(sp)
     ce4:	f456                	sd	s5,40(sp)
     ce6:	f05a                	sd	s6,32(sp)
     ce8:	ec5e                	sd	s7,24(sp)
     cea:	1080                	addi	s0,sp,96
     cec:	8baa                	mv	s7,a0
     cee:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cf0:	892a                	mv	s2,a0
     cf2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     cf4:	4aa9                	li	s5,10
     cf6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     cf8:	89a6                	mv	s3,s1
     cfa:	2485                	addiw	s1,s1,1
     cfc:	0344d863          	bge	s1,s4,d2c <gets+0x56>
    cc = read(0, &c, 1);
     d00:	4605                	li	a2,1
     d02:	faf40593          	addi	a1,s0,-81
     d06:	4501                	li	a0,0
     d08:	00000097          	auipc	ra,0x0
     d0c:	19a080e7          	jalr	410(ra) # ea2 <read>
    if(cc < 1)
     d10:	00a05e63          	blez	a0,d2c <gets+0x56>
    buf[i++] = c;
     d14:	faf44783          	lbu	a5,-81(s0)
     d18:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     d1c:	01578763          	beq	a5,s5,d2a <gets+0x54>
     d20:	0905                	addi	s2,s2,1
     d22:	fd679be3          	bne	a5,s6,cf8 <gets+0x22>
  for(i=0; i+1 < max; ){
     d26:	89a6                	mv	s3,s1
     d28:	a011                	j	d2c <gets+0x56>
     d2a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     d2c:	99de                	add	s3,s3,s7
     d2e:	00098023          	sb	zero,0(s3)
  return buf;
}
     d32:	855e                	mv	a0,s7
     d34:	60e6                	ld	ra,88(sp)
     d36:	6446                	ld	s0,80(sp)
     d38:	64a6                	ld	s1,72(sp)
     d3a:	6906                	ld	s2,64(sp)
     d3c:	79e2                	ld	s3,56(sp)
     d3e:	7a42                	ld	s4,48(sp)
     d40:	7aa2                	ld	s5,40(sp)
     d42:	7b02                	ld	s6,32(sp)
     d44:	6be2                	ld	s7,24(sp)
     d46:	6125                	addi	sp,sp,96
     d48:	8082                	ret

0000000000000d4a <stat>:

int
stat(const char *n, struct stat *st)
{
     d4a:	1101                	addi	sp,sp,-32
     d4c:	ec06                	sd	ra,24(sp)
     d4e:	e822                	sd	s0,16(sp)
     d50:	e426                	sd	s1,8(sp)
     d52:	e04a                	sd	s2,0(sp)
     d54:	1000                	addi	s0,sp,32
     d56:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d58:	4581                	li	a1,0
     d5a:	00000097          	auipc	ra,0x0
     d5e:	170080e7          	jalr	368(ra) # eca <open>
  if(fd < 0)
     d62:	02054563          	bltz	a0,d8c <stat+0x42>
     d66:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d68:	85ca                	mv	a1,s2
     d6a:	00000097          	auipc	ra,0x0
     d6e:	178080e7          	jalr	376(ra) # ee2 <fstat>
     d72:	892a                	mv	s2,a0
  close(fd);
     d74:	8526                	mv	a0,s1
     d76:	00000097          	auipc	ra,0x0
     d7a:	13c080e7          	jalr	316(ra) # eb2 <close>
  return r;
}
     d7e:	854a                	mv	a0,s2
     d80:	60e2                	ld	ra,24(sp)
     d82:	6442                	ld	s0,16(sp)
     d84:	64a2                	ld	s1,8(sp)
     d86:	6902                	ld	s2,0(sp)
     d88:	6105                	addi	sp,sp,32
     d8a:	8082                	ret
    return -1;
     d8c:	597d                	li	s2,-1
     d8e:	bfc5                	j	d7e <stat+0x34>

0000000000000d90 <atoi>:

int
atoi(const char *s)
{
     d90:	1141                	addi	sp,sp,-16
     d92:	e422                	sd	s0,8(sp)
     d94:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d96:	00054683          	lbu	a3,0(a0)
     d9a:	fd06879b          	addiw	a5,a3,-48
     d9e:	0ff7f793          	zext.b	a5,a5
     da2:	4625                	li	a2,9
     da4:	02f66863          	bltu	a2,a5,dd4 <atoi+0x44>
     da8:	872a                	mv	a4,a0
  n = 0;
     daa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     dac:	0705                	addi	a4,a4,1
     dae:	0025179b          	slliw	a5,a0,0x2
     db2:	9fa9                	addw	a5,a5,a0
     db4:	0017979b          	slliw	a5,a5,0x1
     db8:	9fb5                	addw	a5,a5,a3
     dba:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     dbe:	00074683          	lbu	a3,0(a4)
     dc2:	fd06879b          	addiw	a5,a3,-48
     dc6:	0ff7f793          	zext.b	a5,a5
     dca:	fef671e3          	bgeu	a2,a5,dac <atoi+0x1c>
  return n;
}
     dce:	6422                	ld	s0,8(sp)
     dd0:	0141                	addi	sp,sp,16
     dd2:	8082                	ret
  n = 0;
     dd4:	4501                	li	a0,0
     dd6:	bfe5                	j	dce <atoi+0x3e>

0000000000000dd8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     dd8:	1141                	addi	sp,sp,-16
     dda:	e422                	sd	s0,8(sp)
     ddc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     dde:	02b57463          	bgeu	a0,a1,e06 <memmove+0x2e>
    while(n-- > 0)
     de2:	00c05f63          	blez	a2,e00 <memmove+0x28>
     de6:	1602                	slli	a2,a2,0x20
     de8:	9201                	srli	a2,a2,0x20
     dea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     dee:	872a                	mv	a4,a0
      *dst++ = *src++;
     df0:	0585                	addi	a1,a1,1
     df2:	0705                	addi	a4,a4,1
     df4:	fff5c683          	lbu	a3,-1(a1)
     df8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     dfc:	fee79ae3          	bne	a5,a4,df0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     e00:	6422                	ld	s0,8(sp)
     e02:	0141                	addi	sp,sp,16
     e04:	8082                	ret
    dst += n;
     e06:	00c50733          	add	a4,a0,a2
    src += n;
     e0a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     e0c:	fec05ae3          	blez	a2,e00 <memmove+0x28>
     e10:	fff6079b          	addiw	a5,a2,-1
     e14:	1782                	slli	a5,a5,0x20
     e16:	9381                	srli	a5,a5,0x20
     e18:	fff7c793          	not	a5,a5
     e1c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     e1e:	15fd                	addi	a1,a1,-1
     e20:	177d                	addi	a4,a4,-1
     e22:	0005c683          	lbu	a3,0(a1)
     e26:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e2a:	fee79ae3          	bne	a5,a4,e1e <memmove+0x46>
     e2e:	bfc9                	j	e00 <memmove+0x28>

0000000000000e30 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e30:	1141                	addi	sp,sp,-16
     e32:	e422                	sd	s0,8(sp)
     e34:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e36:	ca05                	beqz	a2,e66 <memcmp+0x36>
     e38:	fff6069b          	addiw	a3,a2,-1
     e3c:	1682                	slli	a3,a3,0x20
     e3e:	9281                	srli	a3,a3,0x20
     e40:	0685                	addi	a3,a3,1
     e42:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     e44:	00054783          	lbu	a5,0(a0)
     e48:	0005c703          	lbu	a4,0(a1)
     e4c:	00e79863          	bne	a5,a4,e5c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     e50:	0505                	addi	a0,a0,1
    p2++;
     e52:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     e54:	fed518e3          	bne	a0,a3,e44 <memcmp+0x14>
  }
  return 0;
     e58:	4501                	li	a0,0
     e5a:	a019                	j	e60 <memcmp+0x30>
      return *p1 - *p2;
     e5c:	40e7853b          	subw	a0,a5,a4
}
     e60:	6422                	ld	s0,8(sp)
     e62:	0141                	addi	sp,sp,16
     e64:	8082                	ret
  return 0;
     e66:	4501                	li	a0,0
     e68:	bfe5                	j	e60 <memcmp+0x30>

0000000000000e6a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e6a:	1141                	addi	sp,sp,-16
     e6c:	e406                	sd	ra,8(sp)
     e6e:	e022                	sd	s0,0(sp)
     e70:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     e72:	00000097          	auipc	ra,0x0
     e76:	f66080e7          	jalr	-154(ra) # dd8 <memmove>
}
     e7a:	60a2                	ld	ra,8(sp)
     e7c:	6402                	ld	s0,0(sp)
     e7e:	0141                	addi	sp,sp,16
     e80:	8082                	ret

0000000000000e82 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e82:	4885                	li	a7,1
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <exit>:
.global exit
exit:
 li a7, SYS_exit
     e8a:	4889                	li	a7,2
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e92:	488d                	li	a7,3
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e9a:	4891                	li	a7,4
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <read>:
.global read
read:
 li a7, SYS_read
     ea2:	4895                	li	a7,5
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <write>:
.global write
write:
 li a7, SYS_write
     eaa:	48c1                	li	a7,16
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <close>:
.global close
close:
 li a7, SYS_close
     eb2:	48d5                	li	a7,21
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <kill>:
.global kill
kill:
 li a7, SYS_kill
     eba:	4899                	li	a7,6
 ecall
     ebc:	00000073          	ecall
 ret
     ec0:	8082                	ret

0000000000000ec2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ec2:	489d                	li	a7,7
 ecall
     ec4:	00000073          	ecall
 ret
     ec8:	8082                	ret

0000000000000eca <open>:
.global open
open:
 li a7, SYS_open
     eca:	48bd                	li	a7,15
 ecall
     ecc:	00000073          	ecall
 ret
     ed0:	8082                	ret

0000000000000ed2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ed2:	48c5                	li	a7,17
 ecall
     ed4:	00000073          	ecall
 ret
     ed8:	8082                	ret

0000000000000eda <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     eda:	48c9                	li	a7,18
 ecall
     edc:	00000073          	ecall
 ret
     ee0:	8082                	ret

0000000000000ee2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ee2:	48a1                	li	a7,8
 ecall
     ee4:	00000073          	ecall
 ret
     ee8:	8082                	ret

0000000000000eea <link>:
.global link
link:
 li a7, SYS_link
     eea:	48cd                	li	a7,19
 ecall
     eec:	00000073          	ecall
 ret
     ef0:	8082                	ret

0000000000000ef2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ef2:	48d1                	li	a7,20
 ecall
     ef4:	00000073          	ecall
 ret
     ef8:	8082                	ret

0000000000000efa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     efa:	48a5                	li	a7,9
 ecall
     efc:	00000073          	ecall
 ret
     f00:	8082                	ret

0000000000000f02 <dup>:
.global dup
dup:
 li a7, SYS_dup
     f02:	48a9                	li	a7,10
 ecall
     f04:	00000073          	ecall
 ret
     f08:	8082                	ret

0000000000000f0a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f0a:	48ad                	li	a7,11
 ecall
     f0c:	00000073          	ecall
 ret
     f10:	8082                	ret

0000000000000f12 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f12:	48b1                	li	a7,12
 ecall
     f14:	00000073          	ecall
 ret
     f18:	8082                	ret

0000000000000f1a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f1a:	48b5                	li	a7,13
 ecall
     f1c:	00000073          	ecall
 ret
     f20:	8082                	ret

0000000000000f22 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f22:	48b9                	li	a7,14
 ecall
     f24:	00000073          	ecall
 ret
     f28:	8082                	ret

0000000000000f2a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f2a:	1101                	addi	sp,sp,-32
     f2c:	ec06                	sd	ra,24(sp)
     f2e:	e822                	sd	s0,16(sp)
     f30:	1000                	addi	s0,sp,32
     f32:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f36:	4605                	li	a2,1
     f38:	fef40593          	addi	a1,s0,-17
     f3c:	00000097          	auipc	ra,0x0
     f40:	f6e080e7          	jalr	-146(ra) # eaa <write>
}
     f44:	60e2                	ld	ra,24(sp)
     f46:	6442                	ld	s0,16(sp)
     f48:	6105                	addi	sp,sp,32
     f4a:	8082                	ret

0000000000000f4c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f4c:	7139                	addi	sp,sp,-64
     f4e:	fc06                	sd	ra,56(sp)
     f50:	f822                	sd	s0,48(sp)
     f52:	f426                	sd	s1,40(sp)
     f54:	f04a                	sd	s2,32(sp)
     f56:	ec4e                	sd	s3,24(sp)
     f58:	0080                	addi	s0,sp,64
     f5a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f5c:	c299                	beqz	a3,f62 <printint+0x16>
     f5e:	0805c963          	bltz	a1,ff0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f62:	2581                	sext.w	a1,a1
  neg = 0;
     f64:	4881                	li	a7,0
     f66:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     f6a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f6c:	2601                	sext.w	a2,a2
     f6e:	00000517          	auipc	a0,0x0
     f72:	7e250513          	addi	a0,a0,2018 # 1750 <digits>
     f76:	883a                	mv	a6,a4
     f78:	2705                	addiw	a4,a4,1
     f7a:	02c5f7bb          	remuw	a5,a1,a2
     f7e:	1782                	slli	a5,a5,0x20
     f80:	9381                	srli	a5,a5,0x20
     f82:	97aa                	add	a5,a5,a0
     f84:	0007c783          	lbu	a5,0(a5)
     f88:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     f8c:	0005879b          	sext.w	a5,a1
     f90:	02c5d5bb          	divuw	a1,a1,a2
     f94:	0685                	addi	a3,a3,1
     f96:	fec7f0e3          	bgeu	a5,a2,f76 <printint+0x2a>
  if(neg)
     f9a:	00088c63          	beqz	a7,fb2 <printint+0x66>
    buf[i++] = '-';
     f9e:	fd070793          	addi	a5,a4,-48
     fa2:	00878733          	add	a4,a5,s0
     fa6:	02d00793          	li	a5,45
     faa:	fef70823          	sb	a5,-16(a4)
     fae:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     fb2:	02e05863          	blez	a4,fe2 <printint+0x96>
     fb6:	fc040793          	addi	a5,s0,-64
     fba:	00e78933          	add	s2,a5,a4
     fbe:	fff78993          	addi	s3,a5,-1
     fc2:	99ba                	add	s3,s3,a4
     fc4:	377d                	addiw	a4,a4,-1
     fc6:	1702                	slli	a4,a4,0x20
     fc8:	9301                	srli	a4,a4,0x20
     fca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     fce:	fff94583          	lbu	a1,-1(s2)
     fd2:	8526                	mv	a0,s1
     fd4:	00000097          	auipc	ra,0x0
     fd8:	f56080e7          	jalr	-170(ra) # f2a <putc>
  while(--i >= 0)
     fdc:	197d                	addi	s2,s2,-1
     fde:	ff3918e3          	bne	s2,s3,fce <printint+0x82>
}
     fe2:	70e2                	ld	ra,56(sp)
     fe4:	7442                	ld	s0,48(sp)
     fe6:	74a2                	ld	s1,40(sp)
     fe8:	7902                	ld	s2,32(sp)
     fea:	69e2                	ld	s3,24(sp)
     fec:	6121                	addi	sp,sp,64
     fee:	8082                	ret
    x = -xx;
     ff0:	40b005bb          	negw	a1,a1
    neg = 1;
     ff4:	4885                	li	a7,1
    x = -xx;
     ff6:	bf85                	j	f66 <printint+0x1a>

0000000000000ff8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     ff8:	7119                	addi	sp,sp,-128
     ffa:	fc86                	sd	ra,120(sp)
     ffc:	f8a2                	sd	s0,112(sp)
     ffe:	f4a6                	sd	s1,104(sp)
    1000:	f0ca                	sd	s2,96(sp)
    1002:	ecce                	sd	s3,88(sp)
    1004:	e8d2                	sd	s4,80(sp)
    1006:	e4d6                	sd	s5,72(sp)
    1008:	e0da                	sd	s6,64(sp)
    100a:	fc5e                	sd	s7,56(sp)
    100c:	f862                	sd	s8,48(sp)
    100e:	f466                	sd	s9,40(sp)
    1010:	f06a                	sd	s10,32(sp)
    1012:	ec6e                	sd	s11,24(sp)
    1014:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1016:	0005c903          	lbu	s2,0(a1)
    101a:	18090f63          	beqz	s2,11b8 <vprintf+0x1c0>
    101e:	8aaa                	mv	s5,a0
    1020:	8b32                	mv	s6,a2
    1022:	00158493          	addi	s1,a1,1
  state = 0;
    1026:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1028:	02500a13          	li	s4,37
    102c:	4c55                	li	s8,21
    102e:	00000c97          	auipc	s9,0x0
    1032:	6cac8c93          	addi	s9,s9,1738 # 16f8 <malloc+0x43c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1036:	02800d93          	li	s11,40
  putc(fd, 'x');
    103a:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    103c:	00000b97          	auipc	s7,0x0
    1040:	714b8b93          	addi	s7,s7,1812 # 1750 <digits>
    1044:	a839                	j	1062 <vprintf+0x6a>
        putc(fd, c);
    1046:	85ca                	mv	a1,s2
    1048:	8556                	mv	a0,s5
    104a:	00000097          	auipc	ra,0x0
    104e:	ee0080e7          	jalr	-288(ra) # f2a <putc>
    1052:	a019                	j	1058 <vprintf+0x60>
    } else if(state == '%'){
    1054:	01498d63          	beq	s3,s4,106e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    1058:	0485                	addi	s1,s1,1
    105a:	fff4c903          	lbu	s2,-1(s1)
    105e:	14090d63          	beqz	s2,11b8 <vprintf+0x1c0>
    if(state == 0){
    1062:	fe0999e3          	bnez	s3,1054 <vprintf+0x5c>
      if(c == '%'){
    1066:	ff4910e3          	bne	s2,s4,1046 <vprintf+0x4e>
        state = '%';
    106a:	89d2                	mv	s3,s4
    106c:	b7f5                	j	1058 <vprintf+0x60>
      if(c == 'd'){
    106e:	11490c63          	beq	s2,s4,1186 <vprintf+0x18e>
    1072:	f9d9079b          	addiw	a5,s2,-99
    1076:	0ff7f793          	zext.b	a5,a5
    107a:	10fc6e63          	bltu	s8,a5,1196 <vprintf+0x19e>
    107e:	f9d9079b          	addiw	a5,s2,-99
    1082:	0ff7f713          	zext.b	a4,a5
    1086:	10ec6863          	bltu	s8,a4,1196 <vprintf+0x19e>
    108a:	00271793          	slli	a5,a4,0x2
    108e:	97e6                	add	a5,a5,s9
    1090:	439c                	lw	a5,0(a5)
    1092:	97e6                	add	a5,a5,s9
    1094:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1096:	008b0913          	addi	s2,s6,8
    109a:	4685                	li	a3,1
    109c:	4629                	li	a2,10
    109e:	000b2583          	lw	a1,0(s6)
    10a2:	8556                	mv	a0,s5
    10a4:	00000097          	auipc	ra,0x0
    10a8:	ea8080e7          	jalr	-344(ra) # f4c <printint>
    10ac:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10ae:	4981                	li	s3,0
    10b0:	b765                	j	1058 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10b2:	008b0913          	addi	s2,s6,8
    10b6:	4681                	li	a3,0
    10b8:	4629                	li	a2,10
    10ba:	000b2583          	lw	a1,0(s6)
    10be:	8556                	mv	a0,s5
    10c0:	00000097          	auipc	ra,0x0
    10c4:	e8c080e7          	jalr	-372(ra) # f4c <printint>
    10c8:	8b4a                	mv	s6,s2
      state = 0;
    10ca:	4981                	li	s3,0
    10cc:	b771                	j	1058 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    10ce:	008b0913          	addi	s2,s6,8
    10d2:	4681                	li	a3,0
    10d4:	866a                	mv	a2,s10
    10d6:	000b2583          	lw	a1,0(s6)
    10da:	8556                	mv	a0,s5
    10dc:	00000097          	auipc	ra,0x0
    10e0:	e70080e7          	jalr	-400(ra) # f4c <printint>
    10e4:	8b4a                	mv	s6,s2
      state = 0;
    10e6:	4981                	li	s3,0
    10e8:	bf85                	j	1058 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    10ea:	008b0793          	addi	a5,s6,8
    10ee:	f8f43423          	sd	a5,-120(s0)
    10f2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    10f6:	03000593          	li	a1,48
    10fa:	8556                	mv	a0,s5
    10fc:	00000097          	auipc	ra,0x0
    1100:	e2e080e7          	jalr	-466(ra) # f2a <putc>
  putc(fd, 'x');
    1104:	07800593          	li	a1,120
    1108:	8556                	mv	a0,s5
    110a:	00000097          	auipc	ra,0x0
    110e:	e20080e7          	jalr	-480(ra) # f2a <putc>
    1112:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1114:	03c9d793          	srli	a5,s3,0x3c
    1118:	97de                	add	a5,a5,s7
    111a:	0007c583          	lbu	a1,0(a5)
    111e:	8556                	mv	a0,s5
    1120:	00000097          	auipc	ra,0x0
    1124:	e0a080e7          	jalr	-502(ra) # f2a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1128:	0992                	slli	s3,s3,0x4
    112a:	397d                	addiw	s2,s2,-1
    112c:	fe0914e3          	bnez	s2,1114 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    1130:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1134:	4981                	li	s3,0
    1136:	b70d                	j	1058 <vprintf+0x60>
        s = va_arg(ap, char*);
    1138:	008b0913          	addi	s2,s6,8
    113c:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    1140:	02098163          	beqz	s3,1162 <vprintf+0x16a>
        while(*s != 0){
    1144:	0009c583          	lbu	a1,0(s3)
    1148:	c5ad                	beqz	a1,11b2 <vprintf+0x1ba>
          putc(fd, *s);
    114a:	8556                	mv	a0,s5
    114c:	00000097          	auipc	ra,0x0
    1150:	dde080e7          	jalr	-546(ra) # f2a <putc>
          s++;
    1154:	0985                	addi	s3,s3,1
        while(*s != 0){
    1156:	0009c583          	lbu	a1,0(s3)
    115a:	f9e5                	bnez	a1,114a <vprintf+0x152>
        s = va_arg(ap, char*);
    115c:	8b4a                	mv	s6,s2
      state = 0;
    115e:	4981                	li	s3,0
    1160:	bde5                	j	1058 <vprintf+0x60>
          s = "(null)";
    1162:	00000997          	auipc	s3,0x0
    1166:	58e98993          	addi	s3,s3,1422 # 16f0 <malloc+0x434>
        while(*s != 0){
    116a:	85ee                	mv	a1,s11
    116c:	bff9                	j	114a <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    116e:	008b0913          	addi	s2,s6,8
    1172:	000b4583          	lbu	a1,0(s6)
    1176:	8556                	mv	a0,s5
    1178:	00000097          	auipc	ra,0x0
    117c:	db2080e7          	jalr	-590(ra) # f2a <putc>
    1180:	8b4a                	mv	s6,s2
      state = 0;
    1182:	4981                	li	s3,0
    1184:	bdd1                	j	1058 <vprintf+0x60>
        putc(fd, c);
    1186:	85d2                	mv	a1,s4
    1188:	8556                	mv	a0,s5
    118a:	00000097          	auipc	ra,0x0
    118e:	da0080e7          	jalr	-608(ra) # f2a <putc>
      state = 0;
    1192:	4981                	li	s3,0
    1194:	b5d1                	j	1058 <vprintf+0x60>
        putc(fd, '%');
    1196:	85d2                	mv	a1,s4
    1198:	8556                	mv	a0,s5
    119a:	00000097          	auipc	ra,0x0
    119e:	d90080e7          	jalr	-624(ra) # f2a <putc>
        putc(fd, c);
    11a2:	85ca                	mv	a1,s2
    11a4:	8556                	mv	a0,s5
    11a6:	00000097          	auipc	ra,0x0
    11aa:	d84080e7          	jalr	-636(ra) # f2a <putc>
      state = 0;
    11ae:	4981                	li	s3,0
    11b0:	b565                	j	1058 <vprintf+0x60>
        s = va_arg(ap, char*);
    11b2:	8b4a                	mv	s6,s2
      state = 0;
    11b4:	4981                	li	s3,0
    11b6:	b54d                	j	1058 <vprintf+0x60>
    }
  }
}
    11b8:	70e6                	ld	ra,120(sp)
    11ba:	7446                	ld	s0,112(sp)
    11bc:	74a6                	ld	s1,104(sp)
    11be:	7906                	ld	s2,96(sp)
    11c0:	69e6                	ld	s3,88(sp)
    11c2:	6a46                	ld	s4,80(sp)
    11c4:	6aa6                	ld	s5,72(sp)
    11c6:	6b06                	ld	s6,64(sp)
    11c8:	7be2                	ld	s7,56(sp)
    11ca:	7c42                	ld	s8,48(sp)
    11cc:	7ca2                	ld	s9,40(sp)
    11ce:	7d02                	ld	s10,32(sp)
    11d0:	6de2                	ld	s11,24(sp)
    11d2:	6109                	addi	sp,sp,128
    11d4:	8082                	ret

00000000000011d6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11d6:	715d                	addi	sp,sp,-80
    11d8:	ec06                	sd	ra,24(sp)
    11da:	e822                	sd	s0,16(sp)
    11dc:	1000                	addi	s0,sp,32
    11de:	e010                	sd	a2,0(s0)
    11e0:	e414                	sd	a3,8(s0)
    11e2:	e818                	sd	a4,16(s0)
    11e4:	ec1c                	sd	a5,24(s0)
    11e6:	03043023          	sd	a6,32(s0)
    11ea:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    11ee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    11f2:	8622                	mv	a2,s0
    11f4:	00000097          	auipc	ra,0x0
    11f8:	e04080e7          	jalr	-508(ra) # ff8 <vprintf>
}
    11fc:	60e2                	ld	ra,24(sp)
    11fe:	6442                	ld	s0,16(sp)
    1200:	6161                	addi	sp,sp,80
    1202:	8082                	ret

0000000000001204 <printf>:

void
printf(const char *fmt, ...)
{
    1204:	711d                	addi	sp,sp,-96
    1206:	ec06                	sd	ra,24(sp)
    1208:	e822                	sd	s0,16(sp)
    120a:	1000                	addi	s0,sp,32
    120c:	e40c                	sd	a1,8(s0)
    120e:	e810                	sd	a2,16(s0)
    1210:	ec14                	sd	a3,24(s0)
    1212:	f018                	sd	a4,32(s0)
    1214:	f41c                	sd	a5,40(s0)
    1216:	03043823          	sd	a6,48(s0)
    121a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    121e:	00840613          	addi	a2,s0,8
    1222:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1226:	85aa                	mv	a1,a0
    1228:	4505                	li	a0,1
    122a:	00000097          	auipc	ra,0x0
    122e:	dce080e7          	jalr	-562(ra) # ff8 <vprintf>
}
    1232:	60e2                	ld	ra,24(sp)
    1234:	6442                	ld	s0,16(sp)
    1236:	6125                	addi	sp,sp,96
    1238:	8082                	ret

000000000000123a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    123a:	1141                	addi	sp,sp,-16
    123c:	e422                	sd	s0,8(sp)
    123e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1240:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1244:	00000797          	auipc	a5,0x0
    1248:	52c7b783          	ld	a5,1324(a5) # 1770 <freep>
    124c:	a02d                	j	1276 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    124e:	4618                	lw	a4,8(a2)
    1250:	9f2d                	addw	a4,a4,a1
    1252:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1256:	6398                	ld	a4,0(a5)
    1258:	6310                	ld	a2,0(a4)
    125a:	a83d                	j	1298 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    125c:	ff852703          	lw	a4,-8(a0)
    1260:	9f31                	addw	a4,a4,a2
    1262:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1264:	ff053683          	ld	a3,-16(a0)
    1268:	a091                	j	12ac <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    126a:	6398                	ld	a4,0(a5)
    126c:	00e7e463          	bltu	a5,a4,1274 <free+0x3a>
    1270:	00e6ea63          	bltu	a3,a4,1284 <free+0x4a>
{
    1274:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1276:	fed7fae3          	bgeu	a5,a3,126a <free+0x30>
    127a:	6398                	ld	a4,0(a5)
    127c:	00e6e463          	bltu	a3,a4,1284 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1280:	fee7eae3          	bltu	a5,a4,1274 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1284:	ff852583          	lw	a1,-8(a0)
    1288:	6390                	ld	a2,0(a5)
    128a:	02059813          	slli	a6,a1,0x20
    128e:	01c85713          	srli	a4,a6,0x1c
    1292:	9736                	add	a4,a4,a3
    1294:	fae60de3          	beq	a2,a4,124e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1298:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    129c:	4790                	lw	a2,8(a5)
    129e:	02061593          	slli	a1,a2,0x20
    12a2:	01c5d713          	srli	a4,a1,0x1c
    12a6:	973e                	add	a4,a4,a5
    12a8:	fae68ae3          	beq	a3,a4,125c <free+0x22>
    p->s.ptr = bp->s.ptr;
    12ac:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12ae:	00000717          	auipc	a4,0x0
    12b2:	4cf73123          	sd	a5,1218(a4) # 1770 <freep>
}
    12b6:	6422                	ld	s0,8(sp)
    12b8:	0141                	addi	sp,sp,16
    12ba:	8082                	ret

00000000000012bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12bc:	7139                	addi	sp,sp,-64
    12be:	fc06                	sd	ra,56(sp)
    12c0:	f822                	sd	s0,48(sp)
    12c2:	f426                	sd	s1,40(sp)
    12c4:	f04a                	sd	s2,32(sp)
    12c6:	ec4e                	sd	s3,24(sp)
    12c8:	e852                	sd	s4,16(sp)
    12ca:	e456                	sd	s5,8(sp)
    12cc:	e05a                	sd	s6,0(sp)
    12ce:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12d0:	02051493          	slli	s1,a0,0x20
    12d4:	9081                	srli	s1,s1,0x20
    12d6:	04bd                	addi	s1,s1,15
    12d8:	8091                	srli	s1,s1,0x4
    12da:	0014899b          	addiw	s3,s1,1
    12de:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    12e0:	00000517          	auipc	a0,0x0
    12e4:	49053503          	ld	a0,1168(a0) # 1770 <freep>
    12e8:	c515                	beqz	a0,1314 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12ec:	4798                	lw	a4,8(a5)
    12ee:	02977f63          	bgeu	a4,s1,132c <malloc+0x70>
    12f2:	8a4e                	mv	s4,s3
    12f4:	0009871b          	sext.w	a4,s3
    12f8:	6685                	lui	a3,0x1
    12fa:	00d77363          	bgeu	a4,a3,1300 <malloc+0x44>
    12fe:	6a05                	lui	s4,0x1
    1300:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1304:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1308:	00000917          	auipc	s2,0x0
    130c:	46890913          	addi	s2,s2,1128 # 1770 <freep>
  if(p == (char*)-1)
    1310:	5afd                	li	s5,-1
    1312:	a895                	j	1386 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1314:	00001797          	auipc	a5,0x1
    1318:	84c78793          	addi	a5,a5,-1972 # 1b60 <base>
    131c:	00000717          	auipc	a4,0x0
    1320:	44f73a23          	sd	a5,1108(a4) # 1770 <freep>
    1324:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1326:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    132a:	b7e1                	j	12f2 <malloc+0x36>
      if(p->s.size == nunits)
    132c:	02e48c63          	beq	s1,a4,1364 <malloc+0xa8>
        p->s.size -= nunits;
    1330:	4137073b          	subw	a4,a4,s3
    1334:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1336:	02071693          	slli	a3,a4,0x20
    133a:	01c6d713          	srli	a4,a3,0x1c
    133e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1340:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1344:	00000717          	auipc	a4,0x0
    1348:	42a73623          	sd	a0,1068(a4) # 1770 <freep>
      return (void*)(p + 1);
    134c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1350:	70e2                	ld	ra,56(sp)
    1352:	7442                	ld	s0,48(sp)
    1354:	74a2                	ld	s1,40(sp)
    1356:	7902                	ld	s2,32(sp)
    1358:	69e2                	ld	s3,24(sp)
    135a:	6a42                	ld	s4,16(sp)
    135c:	6aa2                	ld	s5,8(sp)
    135e:	6b02                	ld	s6,0(sp)
    1360:	6121                	addi	sp,sp,64
    1362:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1364:	6398                	ld	a4,0(a5)
    1366:	e118                	sd	a4,0(a0)
    1368:	bff1                	j	1344 <malloc+0x88>
  hp->s.size = nu;
    136a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    136e:	0541                	addi	a0,a0,16
    1370:	00000097          	auipc	ra,0x0
    1374:	eca080e7          	jalr	-310(ra) # 123a <free>
  return freep;
    1378:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    137c:	d971                	beqz	a0,1350 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    137e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1380:	4798                	lw	a4,8(a5)
    1382:	fa9775e3          	bgeu	a4,s1,132c <malloc+0x70>
    if(p == freep)
    1386:	00093703          	ld	a4,0(s2)
    138a:	853e                	mv	a0,a5
    138c:	fef719e3          	bne	a4,a5,137e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    1390:	8552                	mv	a0,s4
    1392:	00000097          	auipc	ra,0x0
    1396:	b80080e7          	jalr	-1152(ra) # f12 <sbrk>
  if(p == (char*)-1)
    139a:	fd5518e3          	bne	a0,s5,136a <malloc+0xae>
        return 0;
    139e:	4501                	li	a0,0
    13a0:	bf45                	j	1350 <malloc+0x94>
