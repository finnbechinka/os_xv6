
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	45858593          	addi	a1,a1,1112 # 1468 <malloc+0xea>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	27e080e7          	jalr	638(ra) # 1298 <fprintf>
  memset(buf, 0, nbuf);
      22:	864a                	mv	a2,s2
      24:	4581                	li	a1,0
      26:	8526                	mv	a0,s1
      28:	00001097          	auipc	ra,0x1
      2c:	d2a080e7          	jalr	-726(ra) # d52 <memset>
  gets(buf, nbuf);
      30:	85ca                	mv	a1,s2
      32:	8526                	mv	a0,s1
      34:	00001097          	auipc	ra,0x1
      38:	d64080e7          	jalr	-668(ra) # d98 <gets>
  if(buf[0] == 0) // EOF
      3c:	0004c503          	lbu	a0,0(s1)
      40:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      44:	40a00533          	neg	a0,a0
      48:	60e2                	ld	ra,24(sp)
      4a:	6442                	ld	s0,16(sp)
      4c:	64a2                	ld	s1,8(sp)
      4e:	6902                	ld	s2,0(sp)
      50:	6105                	addi	sp,sp,32
      52:	8082                	ret

0000000000000054 <panic>:
  exit(0);
}

void
panic(char *s)
{
      54:	1141                	addi	sp,sp,-16
      56:	e406                	sd	ra,8(sp)
      58:	e022                	sd	s0,0(sp)
      5a:	0800                	addi	s0,sp,16
      5c:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      5e:	00001597          	auipc	a1,0x1
      62:	41258593          	addi	a1,a1,1042 # 1470 <malloc+0xf2>
      66:	4509                	li	a0,2
      68:	00001097          	auipc	ra,0x1
      6c:	230080e7          	jalr	560(ra) # 1298 <fprintf>
  exit(1);
      70:	4505                	li	a0,1
      72:	00001097          	auipc	ra,0x1
      76:	eda080e7          	jalr	-294(ra) # f4c <exit>

000000000000007a <fork1>:
}

int
fork1(void)
{
      7a:	1141                	addi	sp,sp,-16
      7c:	e406                	sd	ra,8(sp)
      7e:	e022                	sd	s0,0(sp)
      80:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      82:	00001097          	auipc	ra,0x1
      86:	ec2080e7          	jalr	-318(ra) # f44 <fork>
  if(pid == -1)
      8a:	57fd                	li	a5,-1
      8c:	00f50663          	beq	a0,a5,98 <fork1+0x1e>
    panic("fork");
  return pid;
}
      90:	60a2                	ld	ra,8(sp)
      92:	6402                	ld	s0,0(sp)
      94:	0141                	addi	sp,sp,16
      96:	8082                	ret
    panic("fork");
      98:	00001517          	auipc	a0,0x1
      9c:	3e050513          	addi	a0,a0,992 # 1478 <malloc+0xfa>
      a0:	00000097          	auipc	ra,0x0
      a4:	fb4080e7          	jalr	-76(ra) # 54 <panic>

00000000000000a8 <runcmd>:
{
      a8:	7171                	addi	sp,sp,-176
      aa:	f506                	sd	ra,168(sp)
      ac:	f122                	sd	s0,160(sp)
      ae:	ed26                	sd	s1,152(sp)
      b0:	e94a                	sd	s2,144(sp)
      b2:	e54e                	sd	s3,136(sp)
      b4:	e152                	sd	s4,128(sp)
      b6:	fcd6                	sd	s5,120(sp)
      b8:	f8da                	sd	s6,112(sp)
      ba:	1900                	addi	s0,sp,176
  char rp[100] = {'/'};
      bc:	02f00793          	li	a5,47
      c0:	f4f43823          	sd	a5,-176(s0)
      c4:	f4043c23          	sd	zero,-168(s0)
      c8:	f6043023          	sd	zero,-160(s0)
      cc:	f6043423          	sd	zero,-152(s0)
      d0:	f6043823          	sd	zero,-144(s0)
      d4:	f6043c23          	sd	zero,-136(s0)
      d8:	f8043023          	sd	zero,-128(s0)
      dc:	f8043423          	sd	zero,-120(s0)
      e0:	f8043823          	sd	zero,-112(s0)
      e4:	f8043c23          	sd	zero,-104(s0)
      e8:	fa043023          	sd	zero,-96(s0)
      ec:	fa043423          	sd	zero,-88(s0)
      f0:	fa042823          	sw	zero,-80(s0)
  if(cmd == 0)
      f4:	c10d                	beqz	a0,116 <runcmd+0x6e>
      f6:	84aa                	mv	s1,a0
  switch(cmd->type){
      f8:	4118                	lw	a4,0(a0)
      fa:	4795                	li	a5,5
      fc:	02e7e263          	bltu	a5,a4,120 <runcmd+0x78>
     100:	00056783          	lwu	a5,0(a0)
     104:	078a                	slli	a5,a5,0x2
     106:	00001717          	auipc	a4,0x1
     10a:	4a270713          	addi	a4,a4,1186 # 15a8 <malloc+0x22a>
     10e:	97ba                	add	a5,a5,a4
     110:	439c                	lw	a5,0(a5)
     112:	97ba                	add	a5,a5,a4
     114:	8782                	jr	a5
    exit(1);
     116:	4505                	li	a0,1
     118:	00001097          	auipc	ra,0x1
     11c:	e34080e7          	jalr	-460(ra) # f4c <exit>
    panic("runcmd");
     120:	00001517          	auipc	a0,0x1
     124:	36050513          	addi	a0,a0,864 # 1480 <malloc+0x102>
     128:	00000097          	auipc	ra,0x0
     12c:	f2c080e7          	jalr	-212(ra) # 54 <panic>
    if(ecmd->argv[0] == 0)
     130:	6508                	ld	a0,8(a0)
     132:	cd09                	beqz	a0,14c <runcmd+0xa4>
    exec(ecmd->argv[0], ecmd->argv);
     134:	00848993          	addi	s3,s1,8
     138:	85ce                	mv	a1,s3
     13a:	00001097          	auipc	ra,0x1
     13e:	e4a080e7          	jalr	-438(ra) # f84 <exec>
    for(i = 0; i < strlen(ecmd->argv[0]); i++){
     142:	4901                	li	s2,0
  int sindex = 0;
     144:	4a81                	li	s5,0
        if(ecmd->argv[0][i] == '/' && ecmd->argv[0][i+1] != '\0')
     146:	02f00b13          	li	s6,47
    for(i = 0; i < strlen(ecmd->argv[0]); i++){
     14a:	a039                	j	158 <runcmd+0xb0>
      exit(1);
     14c:	4505                	li	a0,1
     14e:	00001097          	auipc	ra,0x1
     152:	dfe080e7          	jalr	-514(ra) # f4c <exit>
    for(i = 0; i < strlen(ecmd->argv[0]); i++){
     156:	0905                	addi	s2,s2,1
     158:	00090a1b          	sext.w	s4,s2
     15c:	6488                	ld	a0,8(s1)
     15e:	00001097          	auipc	ra,0x1
     162:	b38080e7          	jalr	-1224(ra) # c96 <strlen>
     166:	2501                	sext.w	a0,a0
     168:	02aa7063          	bgeu	s4,a0,188 <runcmd+0xe0>
        if(ecmd->argv[0][i] == '\0')
     16c:	649c                	ld	a5,8(s1)
     16e:	01278733          	add	a4,a5,s2
     172:	00074703          	lbu	a4,0(a4)
     176:	cb09                	beqz	a4,188 <runcmd+0xe0>
        if(ecmd->argv[0][i] == '/' && ecmd->argv[0][i+1] != '\0')
     178:	fd671fe3          	bne	a4,s6,156 <runcmd+0xae>
     17c:	97ca                	add	a5,a5,s2
     17e:	0017c783          	lbu	a5,1(a5)
     182:	dbf1                	beqz	a5,156 <runcmd+0xae>
          sindex = i;
     184:	8ad2                	mv	s5,s4
     186:	bfc1                	j	156 <runcmd+0xae>
     188:	649c                	ld	a5,8(s1)
     18a:	97d6                	add	a5,a5,s5
     18c:	f5140713          	addi	a4,s0,-175
      rp[i+1] = ecmd->argv[0][i+sindex];
     190:	0007c683          	lbu	a3,0(a5)
     194:	00d70023          	sb	a3,0(a4)
      if(ecmd->argv[0][i+sindex] == '\0')
     198:	0785                	addi	a5,a5,1
     19a:	0705                	addi	a4,a4,1
     19c:	faf5                	bnez	a3,190 <runcmd+0xe8>
    exec(rp, ecmd->argv);
     19e:	85ce                	mv	a1,s3
     1a0:	f5040513          	addi	a0,s0,-176
     1a4:	00001097          	auipc	ra,0x1
     1a8:	de0080e7          	jalr	-544(ra) # f84 <exec>
    fd1 = open(rp, O_RDONLY);
     1ac:	4581                	li	a1,0
     1ae:	f5040513          	addi	a0,s0,-176
     1b2:	00001097          	auipc	ra,0x1
     1b6:	dda080e7          	jalr	-550(ra) # f8c <open>
     1ba:	892a                	mv	s2,a0
    close(fd1);
     1bc:	00001097          	auipc	ra,0x1
     1c0:	db8080e7          	jalr	-584(ra) # f74 <close>
    fd2 = open(ecmd->argv[0], O_RDONLY);
     1c4:	4581                	li	a1,0
     1c6:	6488                	ld	a0,8(s1)
     1c8:	00001097          	auipc	ra,0x1
     1cc:	dc4080e7          	jalr	-572(ra) # f8c <open>
     1d0:	89aa                	mv	s3,a0
    close(fd2);
     1d2:	00001097          	auipc	ra,0x1
     1d6:	da2080e7          	jalr	-606(ra) # f74 <close>
    if(fd1 == -1 && fd2 == -1){
     1da:	01397933          	and	s2,s2,s3
     1de:	2901                	sext.w	s2,s2
     1e0:	57fd                	li	a5,-1
     1e2:	02f90163          	beq	s2,a5,204 <runcmd+0x15c>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     1e6:	6490                	ld	a2,8(s1)
     1e8:	00001597          	auipc	a1,0x1
     1ec:	2d058593          	addi	a1,a1,720 # 14b8 <malloc+0x13a>
     1f0:	4509                	li	a0,2
     1f2:	00001097          	auipc	ra,0x1
     1f6:	0a6080e7          	jalr	166(ra) # 1298 <fprintf>
  exit(0);
     1fa:	4501                	li	a0,0
     1fc:	00001097          	auipc	ra,0x1
     200:	d50080e7          	jalr	-688(ra) # f4c <exit>
      fprintf(2, "file not found in current nor root folder\n");
     204:	00001597          	auipc	a1,0x1
     208:	28458593          	addi	a1,a1,644 # 1488 <malloc+0x10a>
     20c:	4509                	li	a0,2
     20e:	00001097          	auipc	ra,0x1
     212:	08a080e7          	jalr	138(ra) # 1298 <fprintf>
     216:	bfc1                	j	1e6 <runcmd+0x13e>
    close(rcmd->fd);
     218:	5148                	lw	a0,36(a0)
     21a:	00001097          	auipc	ra,0x1
     21e:	d5a080e7          	jalr	-678(ra) # f74 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     222:	508c                	lw	a1,32(s1)
     224:	6888                	ld	a0,16(s1)
     226:	00001097          	auipc	ra,0x1
     22a:	d66080e7          	jalr	-666(ra) # f8c <open>
     22e:	00054763          	bltz	a0,23c <runcmd+0x194>
    runcmd(rcmd->cmd);
     232:	6488                	ld	a0,8(s1)
     234:	00000097          	auipc	ra,0x0
     238:	e74080e7          	jalr	-396(ra) # a8 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     23c:	6890                	ld	a2,16(s1)
     23e:	00001597          	auipc	a1,0x1
     242:	28a58593          	addi	a1,a1,650 # 14c8 <malloc+0x14a>
     246:	4509                	li	a0,2
     248:	00001097          	auipc	ra,0x1
     24c:	050080e7          	jalr	80(ra) # 1298 <fprintf>
      exit(1);
     250:	4505                	li	a0,1
     252:	00001097          	auipc	ra,0x1
     256:	cfa080e7          	jalr	-774(ra) # f4c <exit>
    if(fork1() == 0)
     25a:	00000097          	auipc	ra,0x0
     25e:	e20080e7          	jalr	-480(ra) # 7a <fork1>
     262:	c919                	beqz	a0,278 <runcmd+0x1d0>
    wait(0);
     264:	4501                	li	a0,0
     266:	00001097          	auipc	ra,0x1
     26a:	cee080e7          	jalr	-786(ra) # f54 <wait>
    runcmd(lcmd->right);
     26e:	6888                	ld	a0,16(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e38080e7          	jalr	-456(ra) # a8 <runcmd>
      runcmd(lcmd->left);
     278:	6488                	ld	a0,8(s1)
     27a:	00000097          	auipc	ra,0x0
     27e:	e2e080e7          	jalr	-466(ra) # a8 <runcmd>
    if(pipe(p) < 0)
     282:	fb840513          	addi	a0,s0,-72
     286:	00001097          	auipc	ra,0x1
     28a:	cd6080e7          	jalr	-810(ra) # f5c <pipe>
     28e:	04054363          	bltz	a0,2d4 <runcmd+0x22c>
    if(fork1() == 0){
     292:	00000097          	auipc	ra,0x0
     296:	de8080e7          	jalr	-536(ra) # 7a <fork1>
     29a:	c529                	beqz	a0,2e4 <runcmd+0x23c>
    if(fork1() == 0){
     29c:	00000097          	auipc	ra,0x0
     2a0:	dde080e7          	jalr	-546(ra) # 7a <fork1>
     2a4:	cd25                	beqz	a0,31c <runcmd+0x274>
    close(p[0]);
     2a6:	fb842503          	lw	a0,-72(s0)
     2aa:	00001097          	auipc	ra,0x1
     2ae:	cca080e7          	jalr	-822(ra) # f74 <close>
    close(p[1]);
     2b2:	fbc42503          	lw	a0,-68(s0)
     2b6:	00001097          	auipc	ra,0x1
     2ba:	cbe080e7          	jalr	-834(ra) # f74 <close>
    wait(0);
     2be:	4501                	li	a0,0
     2c0:	00001097          	auipc	ra,0x1
     2c4:	c94080e7          	jalr	-876(ra) # f54 <wait>
    wait(0);
     2c8:	4501                	li	a0,0
     2ca:	00001097          	auipc	ra,0x1
     2ce:	c8a080e7          	jalr	-886(ra) # f54 <wait>
    break;
     2d2:	b725                	j	1fa <runcmd+0x152>
      panic("pipe");
     2d4:	00001517          	auipc	a0,0x1
     2d8:	20450513          	addi	a0,a0,516 # 14d8 <malloc+0x15a>
     2dc:	00000097          	auipc	ra,0x0
     2e0:	d78080e7          	jalr	-648(ra) # 54 <panic>
      close(1);
     2e4:	4505                	li	a0,1
     2e6:	00001097          	auipc	ra,0x1
     2ea:	c8e080e7          	jalr	-882(ra) # f74 <close>
      dup(p[1]);
     2ee:	fbc42503          	lw	a0,-68(s0)
     2f2:	00001097          	auipc	ra,0x1
     2f6:	cd2080e7          	jalr	-814(ra) # fc4 <dup>
      close(p[0]);
     2fa:	fb842503          	lw	a0,-72(s0)
     2fe:	00001097          	auipc	ra,0x1
     302:	c76080e7          	jalr	-906(ra) # f74 <close>
      close(p[1]);
     306:	fbc42503          	lw	a0,-68(s0)
     30a:	00001097          	auipc	ra,0x1
     30e:	c6a080e7          	jalr	-918(ra) # f74 <close>
      runcmd(pcmd->left);
     312:	6488                	ld	a0,8(s1)
     314:	00000097          	auipc	ra,0x0
     318:	d94080e7          	jalr	-620(ra) # a8 <runcmd>
      close(0);
     31c:	00001097          	auipc	ra,0x1
     320:	c58080e7          	jalr	-936(ra) # f74 <close>
      dup(p[0]);
     324:	fb842503          	lw	a0,-72(s0)
     328:	00001097          	auipc	ra,0x1
     32c:	c9c080e7          	jalr	-868(ra) # fc4 <dup>
      close(p[0]);
     330:	fb842503          	lw	a0,-72(s0)
     334:	00001097          	auipc	ra,0x1
     338:	c40080e7          	jalr	-960(ra) # f74 <close>
      close(p[1]);
     33c:	fbc42503          	lw	a0,-68(s0)
     340:	00001097          	auipc	ra,0x1
     344:	c34080e7          	jalr	-972(ra) # f74 <close>
      runcmd(pcmd->right);
     348:	6888                	ld	a0,16(s1)
     34a:	00000097          	auipc	ra,0x0
     34e:	d5e080e7          	jalr	-674(ra) # a8 <runcmd>
    if(fork1() == 0)
     352:	00000097          	auipc	ra,0x0
     356:	d28080e7          	jalr	-728(ra) # 7a <fork1>
     35a:	ea0510e3          	bnez	a0,1fa <runcmd+0x152>
      runcmd(bcmd->cmd);
     35e:	6488                	ld	a0,8(s1)
     360:	00000097          	auipc	ra,0x0
     364:	d48080e7          	jalr	-696(ra) # a8 <runcmd>

0000000000000368 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     368:	1101                	addi	sp,sp,-32
     36a:	ec06                	sd	ra,24(sp)
     36c:	e822                	sd	s0,16(sp)
     36e:	e426                	sd	s1,8(sp)
     370:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     372:	0a800513          	li	a0,168
     376:	00001097          	auipc	ra,0x1
     37a:	008080e7          	jalr	8(ra) # 137e <malloc>
     37e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     380:	0a800613          	li	a2,168
     384:	4581                	li	a1,0
     386:	00001097          	auipc	ra,0x1
     38a:	9cc080e7          	jalr	-1588(ra) # d52 <memset>
  cmd->type = EXEC;
     38e:	4785                	li	a5,1
     390:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     392:	8526                	mv	a0,s1
     394:	60e2                	ld	ra,24(sp)
     396:	6442                	ld	s0,16(sp)
     398:	64a2                	ld	s1,8(sp)
     39a:	6105                	addi	sp,sp,32
     39c:	8082                	ret

000000000000039e <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     39e:	7139                	addi	sp,sp,-64
     3a0:	fc06                	sd	ra,56(sp)
     3a2:	f822                	sd	s0,48(sp)
     3a4:	f426                	sd	s1,40(sp)
     3a6:	f04a                	sd	s2,32(sp)
     3a8:	ec4e                	sd	s3,24(sp)
     3aa:	e852                	sd	s4,16(sp)
     3ac:	e456                	sd	s5,8(sp)
     3ae:	e05a                	sd	s6,0(sp)
     3b0:	0080                	addi	s0,sp,64
     3b2:	8b2a                	mv	s6,a0
     3b4:	8aae                	mv	s5,a1
     3b6:	8a32                	mv	s4,a2
     3b8:	89b6                	mv	s3,a3
     3ba:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3bc:	02800513          	li	a0,40
     3c0:	00001097          	auipc	ra,0x1
     3c4:	fbe080e7          	jalr	-66(ra) # 137e <malloc>
     3c8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3ca:	02800613          	li	a2,40
     3ce:	4581                	li	a1,0
     3d0:	00001097          	auipc	ra,0x1
     3d4:	982080e7          	jalr	-1662(ra) # d52 <memset>
  cmd->type = REDIR;
     3d8:	4789                	li	a5,2
     3da:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3dc:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     3e0:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     3e4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     3e8:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     3ec:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     3f0:	8526                	mv	a0,s1
     3f2:	70e2                	ld	ra,56(sp)
     3f4:	7442                	ld	s0,48(sp)
     3f6:	74a2                	ld	s1,40(sp)
     3f8:	7902                	ld	s2,32(sp)
     3fa:	69e2                	ld	s3,24(sp)
     3fc:	6a42                	ld	s4,16(sp)
     3fe:	6aa2                	ld	s5,8(sp)
     400:	6b02                	ld	s6,0(sp)
     402:	6121                	addi	sp,sp,64
     404:	8082                	ret

0000000000000406 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     406:	7179                	addi	sp,sp,-48
     408:	f406                	sd	ra,40(sp)
     40a:	f022                	sd	s0,32(sp)
     40c:	ec26                	sd	s1,24(sp)
     40e:	e84a                	sd	s2,16(sp)
     410:	e44e                	sd	s3,8(sp)
     412:	1800                	addi	s0,sp,48
     414:	89aa                	mv	s3,a0
     416:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     418:	4561                	li	a0,24
     41a:	00001097          	auipc	ra,0x1
     41e:	f64080e7          	jalr	-156(ra) # 137e <malloc>
     422:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     424:	4661                	li	a2,24
     426:	4581                	li	a1,0
     428:	00001097          	auipc	ra,0x1
     42c:	92a080e7          	jalr	-1750(ra) # d52 <memset>
  cmd->type = PIPE;
     430:	478d                	li	a5,3
     432:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     434:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     438:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     43c:	8526                	mv	a0,s1
     43e:	70a2                	ld	ra,40(sp)
     440:	7402                	ld	s0,32(sp)
     442:	64e2                	ld	s1,24(sp)
     444:	6942                	ld	s2,16(sp)
     446:	69a2                	ld	s3,8(sp)
     448:	6145                	addi	sp,sp,48
     44a:	8082                	ret

000000000000044c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     44c:	7179                	addi	sp,sp,-48
     44e:	f406                	sd	ra,40(sp)
     450:	f022                	sd	s0,32(sp)
     452:	ec26                	sd	s1,24(sp)
     454:	e84a                	sd	s2,16(sp)
     456:	e44e                	sd	s3,8(sp)
     458:	1800                	addi	s0,sp,48
     45a:	89aa                	mv	s3,a0
     45c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     45e:	4561                	li	a0,24
     460:	00001097          	auipc	ra,0x1
     464:	f1e080e7          	jalr	-226(ra) # 137e <malloc>
     468:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     46a:	4661                	li	a2,24
     46c:	4581                	li	a1,0
     46e:	00001097          	auipc	ra,0x1
     472:	8e4080e7          	jalr	-1820(ra) # d52 <memset>
  cmd->type = LIST;
     476:	4791                	li	a5,4
     478:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     47a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     47e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     482:	8526                	mv	a0,s1
     484:	70a2                	ld	ra,40(sp)
     486:	7402                	ld	s0,32(sp)
     488:	64e2                	ld	s1,24(sp)
     48a:	6942                	ld	s2,16(sp)
     48c:	69a2                	ld	s3,8(sp)
     48e:	6145                	addi	sp,sp,48
     490:	8082                	ret

0000000000000492 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     492:	1101                	addi	sp,sp,-32
     494:	ec06                	sd	ra,24(sp)
     496:	e822                	sd	s0,16(sp)
     498:	e426                	sd	s1,8(sp)
     49a:	e04a                	sd	s2,0(sp)
     49c:	1000                	addi	s0,sp,32
     49e:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a0:	4541                	li	a0,16
     4a2:	00001097          	auipc	ra,0x1
     4a6:	edc080e7          	jalr	-292(ra) # 137e <malloc>
     4aa:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     4ac:	4641                	li	a2,16
     4ae:	4581                	li	a1,0
     4b0:	00001097          	auipc	ra,0x1
     4b4:	8a2080e7          	jalr	-1886(ra) # d52 <memset>
  cmd->type = BACK;
     4b8:	4795                	li	a5,5
     4ba:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     4bc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     4c0:	8526                	mv	a0,s1
     4c2:	60e2                	ld	ra,24(sp)
     4c4:	6442                	ld	s0,16(sp)
     4c6:	64a2                	ld	s1,8(sp)
     4c8:	6902                	ld	s2,0(sp)
     4ca:	6105                	addi	sp,sp,32
     4cc:	8082                	ret

00000000000004ce <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4ce:	7139                	addi	sp,sp,-64
     4d0:	fc06                	sd	ra,56(sp)
     4d2:	f822                	sd	s0,48(sp)
     4d4:	f426                	sd	s1,40(sp)
     4d6:	f04a                	sd	s2,32(sp)
     4d8:	ec4e                	sd	s3,24(sp)
     4da:	e852                	sd	s4,16(sp)
     4dc:	e456                	sd	s5,8(sp)
     4de:	e05a                	sd	s6,0(sp)
     4e0:	0080                	addi	s0,sp,64
     4e2:	8a2a                	mv	s4,a0
     4e4:	892e                	mv	s2,a1
     4e6:	8ab2                	mv	s5,a2
     4e8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     4ea:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     4ec:	00001997          	auipc	s3,0x1
     4f0:	16c98993          	addi	s3,s3,364 # 1658 <whitespace>
     4f4:	00b4fe63          	bgeu	s1,a1,510 <gettoken+0x42>
     4f8:	0004c583          	lbu	a1,0(s1)
     4fc:	854e                	mv	a0,s3
     4fe:	00001097          	auipc	ra,0x1
     502:	876080e7          	jalr	-1930(ra) # d74 <strchr>
     506:	c509                	beqz	a0,510 <gettoken+0x42>
    s++;
     508:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     50a:	fe9917e3          	bne	s2,s1,4f8 <gettoken+0x2a>
    s++;
     50e:	84ca                	mv	s1,s2
  if(q)
     510:	000a8463          	beqz	s5,518 <gettoken+0x4a>
    *q = s;
     514:	009ab023          	sd	s1,0(s5)
  ret = *s;
     518:	0004c783          	lbu	a5,0(s1)
     51c:	00078a9b          	sext.w	s5,a5
  switch(*s){
     520:	03c00713          	li	a4,60
     524:	06f76663          	bltu	a4,a5,590 <gettoken+0xc2>
     528:	03a00713          	li	a4,58
     52c:	00f76e63          	bltu	a4,a5,548 <gettoken+0x7a>
     530:	cf89                	beqz	a5,54a <gettoken+0x7c>
     532:	02600713          	li	a4,38
     536:	00e78963          	beq	a5,a4,548 <gettoken+0x7a>
     53a:	fd87879b          	addiw	a5,a5,-40
     53e:	0ff7f793          	zext.b	a5,a5
     542:	4705                	li	a4,1
     544:	06f76d63          	bltu	a4,a5,5be <gettoken+0xf0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     548:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     54a:	000b0463          	beqz	s6,552 <gettoken+0x84>
    *eq = s;
     54e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     552:	00001997          	auipc	s3,0x1
     556:	10698993          	addi	s3,s3,262 # 1658 <whitespace>
     55a:	0124fe63          	bgeu	s1,s2,576 <gettoken+0xa8>
     55e:	0004c583          	lbu	a1,0(s1)
     562:	854e                	mv	a0,s3
     564:	00001097          	auipc	ra,0x1
     568:	810080e7          	jalr	-2032(ra) # d74 <strchr>
     56c:	c509                	beqz	a0,576 <gettoken+0xa8>
    s++;
     56e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     570:	fe9917e3          	bne	s2,s1,55e <gettoken+0x90>
    s++;
     574:	84ca                	mv	s1,s2
  *ps = s;
     576:	009a3023          	sd	s1,0(s4)
  return ret;
}
     57a:	8556                	mv	a0,s5
     57c:	70e2                	ld	ra,56(sp)
     57e:	7442                	ld	s0,48(sp)
     580:	74a2                	ld	s1,40(sp)
     582:	7902                	ld	s2,32(sp)
     584:	69e2                	ld	s3,24(sp)
     586:	6a42                	ld	s4,16(sp)
     588:	6aa2                	ld	s5,8(sp)
     58a:	6b02                	ld	s6,0(sp)
     58c:	6121                	addi	sp,sp,64
     58e:	8082                	ret
  switch(*s){
     590:	03e00713          	li	a4,62
     594:	02e79163          	bne	a5,a4,5b6 <gettoken+0xe8>
    s++;
     598:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     59c:	0014c703          	lbu	a4,1(s1)
     5a0:	03e00793          	li	a5,62
      s++;
     5a4:	0489                	addi	s1,s1,2
      ret = '+';
     5a6:	02b00a93          	li	s5,43
    if(*s == '>'){
     5aa:	faf700e3          	beq	a4,a5,54a <gettoken+0x7c>
    s++;
     5ae:	84b6                	mv	s1,a3
  ret = *s;
     5b0:	03e00a93          	li	s5,62
     5b4:	bf59                	j	54a <gettoken+0x7c>
  switch(*s){
     5b6:	07c00713          	li	a4,124
     5ba:	f8e787e3          	beq	a5,a4,548 <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5be:	00001997          	auipc	s3,0x1
     5c2:	09a98993          	addi	s3,s3,154 # 1658 <whitespace>
     5c6:	00001a97          	auipc	s5,0x1
     5ca:	08aa8a93          	addi	s5,s5,138 # 1650 <symbols>
     5ce:	0324f663          	bgeu	s1,s2,5fa <gettoken+0x12c>
     5d2:	0004c583          	lbu	a1,0(s1)
     5d6:	854e                	mv	a0,s3
     5d8:	00000097          	auipc	ra,0x0
     5dc:	79c080e7          	jalr	1948(ra) # d74 <strchr>
     5e0:	e50d                	bnez	a0,60a <gettoken+0x13c>
     5e2:	0004c583          	lbu	a1,0(s1)
     5e6:	8556                	mv	a0,s5
     5e8:	00000097          	auipc	ra,0x0
     5ec:	78c080e7          	jalr	1932(ra) # d74 <strchr>
     5f0:	e911                	bnez	a0,604 <gettoken+0x136>
      s++;
     5f2:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f4:	fc991fe3          	bne	s2,s1,5d2 <gettoken+0x104>
      s++;
     5f8:	84ca                	mv	s1,s2
  if(eq)
     5fa:	06100a93          	li	s5,97
     5fe:	f40b18e3          	bnez	s6,54e <gettoken+0x80>
     602:	bf95                	j	576 <gettoken+0xa8>
    ret = 'a';
     604:	06100a93          	li	s5,97
     608:	b789                	j	54a <gettoken+0x7c>
     60a:	06100a93          	li	s5,97
     60e:	bf35                	j	54a <gettoken+0x7c>

0000000000000610 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     610:	7139                	addi	sp,sp,-64
     612:	fc06                	sd	ra,56(sp)
     614:	f822                	sd	s0,48(sp)
     616:	f426                	sd	s1,40(sp)
     618:	f04a                	sd	s2,32(sp)
     61a:	ec4e                	sd	s3,24(sp)
     61c:	e852                	sd	s4,16(sp)
     61e:	e456                	sd	s5,8(sp)
     620:	0080                	addi	s0,sp,64
     622:	8a2a                	mv	s4,a0
     624:	892e                	mv	s2,a1
     626:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     628:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     62a:	00001997          	auipc	s3,0x1
     62e:	02e98993          	addi	s3,s3,46 # 1658 <whitespace>
     632:	00b4fe63          	bgeu	s1,a1,64e <peek+0x3e>
     636:	0004c583          	lbu	a1,0(s1)
     63a:	854e                	mv	a0,s3
     63c:	00000097          	auipc	ra,0x0
     640:	738080e7          	jalr	1848(ra) # d74 <strchr>
     644:	c509                	beqz	a0,64e <peek+0x3e>
    s++;
     646:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     648:	fe9917e3          	bne	s2,s1,636 <peek+0x26>
    s++;
     64c:	84ca                	mv	s1,s2
  *ps = s;
     64e:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     652:	0004c583          	lbu	a1,0(s1)
     656:	4501                	li	a0,0
     658:	e991                	bnez	a1,66c <peek+0x5c>
}
     65a:	70e2                	ld	ra,56(sp)
     65c:	7442                	ld	s0,48(sp)
     65e:	74a2                	ld	s1,40(sp)
     660:	7902                	ld	s2,32(sp)
     662:	69e2                	ld	s3,24(sp)
     664:	6a42                	ld	s4,16(sp)
     666:	6aa2                	ld	s5,8(sp)
     668:	6121                	addi	sp,sp,64
     66a:	8082                	ret
  return *s && strchr(toks, *s);
     66c:	8556                	mv	a0,s5
     66e:	00000097          	auipc	ra,0x0
     672:	706080e7          	jalr	1798(ra) # d74 <strchr>
     676:	00a03533          	snez	a0,a0
     67a:	b7c5                	j	65a <peek+0x4a>

000000000000067c <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     67c:	7159                	addi	sp,sp,-112
     67e:	f486                	sd	ra,104(sp)
     680:	f0a2                	sd	s0,96(sp)
     682:	eca6                	sd	s1,88(sp)
     684:	e8ca                	sd	s2,80(sp)
     686:	e4ce                	sd	s3,72(sp)
     688:	e0d2                	sd	s4,64(sp)
     68a:	fc56                	sd	s5,56(sp)
     68c:	f85a                	sd	s6,48(sp)
     68e:	f45e                	sd	s7,40(sp)
     690:	f062                	sd	s8,32(sp)
     692:	ec66                	sd	s9,24(sp)
     694:	1880                	addi	s0,sp,112
     696:	8a2a                	mv	s4,a0
     698:	89ae                	mv	s3,a1
     69a:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     69c:	00001b97          	auipc	s7,0x1
     6a0:	e64b8b93          	addi	s7,s7,-412 # 1500 <malloc+0x182>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     6a4:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     6a8:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     6ac:	a02d                	j	6d6 <parseredirs+0x5a>
      panic("missing file for redirection");
     6ae:	00001517          	auipc	a0,0x1
     6b2:	e3250513          	addi	a0,a0,-462 # 14e0 <malloc+0x162>
     6b6:	00000097          	auipc	ra,0x0
     6ba:	99e080e7          	jalr	-1634(ra) # 54 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6be:	4701                	li	a4,0
     6c0:	4681                	li	a3,0
     6c2:	f9043603          	ld	a2,-112(s0)
     6c6:	f9843583          	ld	a1,-104(s0)
     6ca:	8552                	mv	a0,s4
     6cc:	00000097          	auipc	ra,0x0
     6d0:	cd2080e7          	jalr	-814(ra) # 39e <redircmd>
     6d4:	8a2a                	mv	s4,a0
    switch(tok){
     6d6:	03e00b13          	li	s6,62
     6da:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     6de:	865e                	mv	a2,s7
     6e0:	85ca                	mv	a1,s2
     6e2:	854e                	mv	a0,s3
     6e4:	00000097          	auipc	ra,0x0
     6e8:	f2c080e7          	jalr	-212(ra) # 610 <peek>
     6ec:	c925                	beqz	a0,75c <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     6ee:	4681                	li	a3,0
     6f0:	4601                	li	a2,0
     6f2:	85ca                	mv	a1,s2
     6f4:	854e                	mv	a0,s3
     6f6:	00000097          	auipc	ra,0x0
     6fa:	dd8080e7          	jalr	-552(ra) # 4ce <gettoken>
     6fe:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     700:	f9040693          	addi	a3,s0,-112
     704:	f9840613          	addi	a2,s0,-104
     708:	85ca                	mv	a1,s2
     70a:	854e                	mv	a0,s3
     70c:	00000097          	auipc	ra,0x0
     710:	dc2080e7          	jalr	-574(ra) # 4ce <gettoken>
     714:	f9851de3          	bne	a0,s8,6ae <parseredirs+0x32>
    switch(tok){
     718:	fb9483e3          	beq	s1,s9,6be <parseredirs+0x42>
     71c:	03648263          	beq	s1,s6,740 <parseredirs+0xc4>
     720:	fb549fe3          	bne	s1,s5,6de <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     724:	4705                	li	a4,1
     726:	20100693          	li	a3,513
     72a:	f9043603          	ld	a2,-112(s0)
     72e:	f9843583          	ld	a1,-104(s0)
     732:	8552                	mv	a0,s4
     734:	00000097          	auipc	ra,0x0
     738:	c6a080e7          	jalr	-918(ra) # 39e <redircmd>
     73c:	8a2a                	mv	s4,a0
      break;
     73e:	bf61                	j	6d6 <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     740:	4705                	li	a4,1
     742:	60100693          	li	a3,1537
     746:	f9043603          	ld	a2,-112(s0)
     74a:	f9843583          	ld	a1,-104(s0)
     74e:	8552                	mv	a0,s4
     750:	00000097          	auipc	ra,0x0
     754:	c4e080e7          	jalr	-946(ra) # 39e <redircmd>
     758:	8a2a                	mv	s4,a0
      break;
     75a:	bfb5                	j	6d6 <parseredirs+0x5a>
    }
  }
  return cmd;
}
     75c:	8552                	mv	a0,s4
     75e:	70a6                	ld	ra,104(sp)
     760:	7406                	ld	s0,96(sp)
     762:	64e6                	ld	s1,88(sp)
     764:	6946                	ld	s2,80(sp)
     766:	69a6                	ld	s3,72(sp)
     768:	6a06                	ld	s4,64(sp)
     76a:	7ae2                	ld	s5,56(sp)
     76c:	7b42                	ld	s6,48(sp)
     76e:	7ba2                	ld	s7,40(sp)
     770:	7c02                	ld	s8,32(sp)
     772:	6ce2                	ld	s9,24(sp)
     774:	6165                	addi	sp,sp,112
     776:	8082                	ret

0000000000000778 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     778:	7159                	addi	sp,sp,-112
     77a:	f486                	sd	ra,104(sp)
     77c:	f0a2                	sd	s0,96(sp)
     77e:	eca6                	sd	s1,88(sp)
     780:	e8ca                	sd	s2,80(sp)
     782:	e4ce                	sd	s3,72(sp)
     784:	e0d2                	sd	s4,64(sp)
     786:	fc56                	sd	s5,56(sp)
     788:	f85a                	sd	s6,48(sp)
     78a:	f45e                	sd	s7,40(sp)
     78c:	f062                	sd	s8,32(sp)
     78e:	ec66                	sd	s9,24(sp)
     790:	1880                	addi	s0,sp,112
     792:	8a2a                	mv	s4,a0
     794:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     796:	00001617          	auipc	a2,0x1
     79a:	d7260613          	addi	a2,a2,-654 # 1508 <malloc+0x18a>
     79e:	00000097          	auipc	ra,0x0
     7a2:	e72080e7          	jalr	-398(ra) # 610 <peek>
     7a6:	e905                	bnez	a0,7d6 <parseexec+0x5e>
     7a8:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     7aa:	00000097          	auipc	ra,0x0
     7ae:	bbe080e7          	jalr	-1090(ra) # 368 <execcmd>
     7b2:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7b4:	8656                	mv	a2,s5
     7b6:	85d2                	mv	a1,s4
     7b8:	00000097          	auipc	ra,0x0
     7bc:	ec4080e7          	jalr	-316(ra) # 67c <parseredirs>
     7c0:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     7c2:	008c0913          	addi	s2,s8,8
     7c6:	00001b17          	auipc	s6,0x1
     7ca:	d62b0b13          	addi	s6,s6,-670 # 1528 <malloc+0x1aa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     7ce:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     7d2:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     7d4:	a0b1                	j	820 <parseexec+0xa8>
    return parseblock(ps, es);
     7d6:	85d6                	mv	a1,s5
     7d8:	8552                	mv	a0,s4
     7da:	00000097          	auipc	ra,0x0
     7de:	1bc080e7          	jalr	444(ra) # 996 <parseblock>
     7e2:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7e4:	8526                	mv	a0,s1
     7e6:	70a6                	ld	ra,104(sp)
     7e8:	7406                	ld	s0,96(sp)
     7ea:	64e6                	ld	s1,88(sp)
     7ec:	6946                	ld	s2,80(sp)
     7ee:	69a6                	ld	s3,72(sp)
     7f0:	6a06                	ld	s4,64(sp)
     7f2:	7ae2                	ld	s5,56(sp)
     7f4:	7b42                	ld	s6,48(sp)
     7f6:	7ba2                	ld	s7,40(sp)
     7f8:	7c02                	ld	s8,32(sp)
     7fa:	6ce2                	ld	s9,24(sp)
     7fc:	6165                	addi	sp,sp,112
     7fe:	8082                	ret
      panic("syntax");
     800:	00001517          	auipc	a0,0x1
     804:	d1050513          	addi	a0,a0,-752 # 1510 <malloc+0x192>
     808:	00000097          	auipc	ra,0x0
     80c:	84c080e7          	jalr	-1972(ra) # 54 <panic>
    ret = parseredirs(ret, ps, es);
     810:	8656                	mv	a2,s5
     812:	85d2                	mv	a1,s4
     814:	8526                	mv	a0,s1
     816:	00000097          	auipc	ra,0x0
     81a:	e66080e7          	jalr	-410(ra) # 67c <parseredirs>
     81e:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     820:	865a                	mv	a2,s6
     822:	85d6                	mv	a1,s5
     824:	8552                	mv	a0,s4
     826:	00000097          	auipc	ra,0x0
     82a:	dea080e7          	jalr	-534(ra) # 610 <peek>
     82e:	e131                	bnez	a0,872 <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     830:	f9040693          	addi	a3,s0,-112
     834:	f9840613          	addi	a2,s0,-104
     838:	85d6                	mv	a1,s5
     83a:	8552                	mv	a0,s4
     83c:	00000097          	auipc	ra,0x0
     840:	c92080e7          	jalr	-878(ra) # 4ce <gettoken>
     844:	c51d                	beqz	a0,872 <parseexec+0xfa>
    if(tok != 'a')
     846:	fb951de3          	bne	a0,s9,800 <parseexec+0x88>
    cmd->argv[argc] = q;
     84a:	f9843783          	ld	a5,-104(s0)
     84e:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     852:	f9043783          	ld	a5,-112(s0)
     856:	04f93823          	sd	a5,80(s2)
    argc++;
     85a:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     85c:	0921                	addi	s2,s2,8
     85e:	fb7999e3          	bne	s3,s7,810 <parseexec+0x98>
      panic("too many args");
     862:	00001517          	auipc	a0,0x1
     866:	cb650513          	addi	a0,a0,-842 # 1518 <malloc+0x19a>
     86a:	fffff097          	auipc	ra,0xfffff
     86e:	7ea080e7          	jalr	2026(ra) # 54 <panic>
  cmd->argv[argc] = 0;
     872:	098e                	slli	s3,s3,0x3
     874:	9c4e                	add	s8,s8,s3
     876:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     87a:	040c3c23          	sd	zero,88(s8)
  return ret;
     87e:	b79d                	j	7e4 <parseexec+0x6c>

0000000000000880 <parsepipe>:
{
     880:	7179                	addi	sp,sp,-48
     882:	f406                	sd	ra,40(sp)
     884:	f022                	sd	s0,32(sp)
     886:	ec26                	sd	s1,24(sp)
     888:	e84a                	sd	s2,16(sp)
     88a:	e44e                	sd	s3,8(sp)
     88c:	1800                	addi	s0,sp,48
     88e:	892a                	mv	s2,a0
     890:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     892:	00000097          	auipc	ra,0x0
     896:	ee6080e7          	jalr	-282(ra) # 778 <parseexec>
     89a:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     89c:	00001617          	auipc	a2,0x1
     8a0:	c9460613          	addi	a2,a2,-876 # 1530 <malloc+0x1b2>
     8a4:	85ce                	mv	a1,s3
     8a6:	854a                	mv	a0,s2
     8a8:	00000097          	auipc	ra,0x0
     8ac:	d68080e7          	jalr	-664(ra) # 610 <peek>
     8b0:	e909                	bnez	a0,8c2 <parsepipe+0x42>
}
     8b2:	8526                	mv	a0,s1
     8b4:	70a2                	ld	ra,40(sp)
     8b6:	7402                	ld	s0,32(sp)
     8b8:	64e2                	ld	s1,24(sp)
     8ba:	6942                	ld	s2,16(sp)
     8bc:	69a2                	ld	s3,8(sp)
     8be:	6145                	addi	sp,sp,48
     8c0:	8082                	ret
    gettoken(ps, es, 0, 0);
     8c2:	4681                	li	a3,0
     8c4:	4601                	li	a2,0
     8c6:	85ce                	mv	a1,s3
     8c8:	854a                	mv	a0,s2
     8ca:	00000097          	auipc	ra,0x0
     8ce:	c04080e7          	jalr	-1020(ra) # 4ce <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8d2:	85ce                	mv	a1,s3
     8d4:	854a                	mv	a0,s2
     8d6:	00000097          	auipc	ra,0x0
     8da:	faa080e7          	jalr	-86(ra) # 880 <parsepipe>
     8de:	85aa                	mv	a1,a0
     8e0:	8526                	mv	a0,s1
     8e2:	00000097          	auipc	ra,0x0
     8e6:	b24080e7          	jalr	-1244(ra) # 406 <pipecmd>
     8ea:	84aa                	mv	s1,a0
  return cmd;
     8ec:	b7d9                	j	8b2 <parsepipe+0x32>

00000000000008ee <parseline>:
{
     8ee:	7179                	addi	sp,sp,-48
     8f0:	f406                	sd	ra,40(sp)
     8f2:	f022                	sd	s0,32(sp)
     8f4:	ec26                	sd	s1,24(sp)
     8f6:	e84a                	sd	s2,16(sp)
     8f8:	e44e                	sd	s3,8(sp)
     8fa:	e052                	sd	s4,0(sp)
     8fc:	1800                	addi	s0,sp,48
     8fe:	892a                	mv	s2,a0
     900:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     902:	00000097          	auipc	ra,0x0
     906:	f7e080e7          	jalr	-130(ra) # 880 <parsepipe>
     90a:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     90c:	00001a17          	auipc	s4,0x1
     910:	c2ca0a13          	addi	s4,s4,-980 # 1538 <malloc+0x1ba>
     914:	a839                	j	932 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     916:	4681                	li	a3,0
     918:	4601                	li	a2,0
     91a:	85ce                	mv	a1,s3
     91c:	854a                	mv	a0,s2
     91e:	00000097          	auipc	ra,0x0
     922:	bb0080e7          	jalr	-1104(ra) # 4ce <gettoken>
    cmd = backcmd(cmd);
     926:	8526                	mv	a0,s1
     928:	00000097          	auipc	ra,0x0
     92c:	b6a080e7          	jalr	-1174(ra) # 492 <backcmd>
     930:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     932:	8652                	mv	a2,s4
     934:	85ce                	mv	a1,s3
     936:	854a                	mv	a0,s2
     938:	00000097          	auipc	ra,0x0
     93c:	cd8080e7          	jalr	-808(ra) # 610 <peek>
     940:	f979                	bnez	a0,916 <parseline+0x28>
  if(peek(ps, es, ";")){
     942:	00001617          	auipc	a2,0x1
     946:	bfe60613          	addi	a2,a2,-1026 # 1540 <malloc+0x1c2>
     94a:	85ce                	mv	a1,s3
     94c:	854a                	mv	a0,s2
     94e:	00000097          	auipc	ra,0x0
     952:	cc2080e7          	jalr	-830(ra) # 610 <peek>
     956:	e911                	bnez	a0,96a <parseline+0x7c>
}
     958:	8526                	mv	a0,s1
     95a:	70a2                	ld	ra,40(sp)
     95c:	7402                	ld	s0,32(sp)
     95e:	64e2                	ld	s1,24(sp)
     960:	6942                	ld	s2,16(sp)
     962:	69a2                	ld	s3,8(sp)
     964:	6a02                	ld	s4,0(sp)
     966:	6145                	addi	sp,sp,48
     968:	8082                	ret
    gettoken(ps, es, 0, 0);
     96a:	4681                	li	a3,0
     96c:	4601                	li	a2,0
     96e:	85ce                	mv	a1,s3
     970:	854a                	mv	a0,s2
     972:	00000097          	auipc	ra,0x0
     976:	b5c080e7          	jalr	-1188(ra) # 4ce <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     97a:	85ce                	mv	a1,s3
     97c:	854a                	mv	a0,s2
     97e:	00000097          	auipc	ra,0x0
     982:	f70080e7          	jalr	-144(ra) # 8ee <parseline>
     986:	85aa                	mv	a1,a0
     988:	8526                	mv	a0,s1
     98a:	00000097          	auipc	ra,0x0
     98e:	ac2080e7          	jalr	-1342(ra) # 44c <listcmd>
     992:	84aa                	mv	s1,a0
  return cmd;
     994:	b7d1                	j	958 <parseline+0x6a>

0000000000000996 <parseblock>:
{
     996:	7179                	addi	sp,sp,-48
     998:	f406                	sd	ra,40(sp)
     99a:	f022                	sd	s0,32(sp)
     99c:	ec26                	sd	s1,24(sp)
     99e:	e84a                	sd	s2,16(sp)
     9a0:	e44e                	sd	s3,8(sp)
     9a2:	1800                	addi	s0,sp,48
     9a4:	84aa                	mv	s1,a0
     9a6:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     9a8:	00001617          	auipc	a2,0x1
     9ac:	b6060613          	addi	a2,a2,-1184 # 1508 <malloc+0x18a>
     9b0:	00000097          	auipc	ra,0x0
     9b4:	c60080e7          	jalr	-928(ra) # 610 <peek>
     9b8:	c12d                	beqz	a0,a1a <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     9ba:	4681                	li	a3,0
     9bc:	4601                	li	a2,0
     9be:	85ca                	mv	a1,s2
     9c0:	8526                	mv	a0,s1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	b0c080e7          	jalr	-1268(ra) # 4ce <gettoken>
  cmd = parseline(ps, es);
     9ca:	85ca                	mv	a1,s2
     9cc:	8526                	mv	a0,s1
     9ce:	00000097          	auipc	ra,0x0
     9d2:	f20080e7          	jalr	-224(ra) # 8ee <parseline>
     9d6:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     9d8:	00001617          	auipc	a2,0x1
     9dc:	b8060613          	addi	a2,a2,-1152 # 1558 <malloc+0x1da>
     9e0:	85ca                	mv	a1,s2
     9e2:	8526                	mv	a0,s1
     9e4:	00000097          	auipc	ra,0x0
     9e8:	c2c080e7          	jalr	-980(ra) # 610 <peek>
     9ec:	cd1d                	beqz	a0,a2a <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     9ee:	4681                	li	a3,0
     9f0:	4601                	li	a2,0
     9f2:	85ca                	mv	a1,s2
     9f4:	8526                	mv	a0,s1
     9f6:	00000097          	auipc	ra,0x0
     9fa:	ad8080e7          	jalr	-1320(ra) # 4ce <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9fe:	864a                	mv	a2,s2
     a00:	85a6                	mv	a1,s1
     a02:	854e                	mv	a0,s3
     a04:	00000097          	auipc	ra,0x0
     a08:	c78080e7          	jalr	-904(ra) # 67c <parseredirs>
}
     a0c:	70a2                	ld	ra,40(sp)
     a0e:	7402                	ld	s0,32(sp)
     a10:	64e2                	ld	s1,24(sp)
     a12:	6942                	ld	s2,16(sp)
     a14:	69a2                	ld	s3,8(sp)
     a16:	6145                	addi	sp,sp,48
     a18:	8082                	ret
    panic("parseblock");
     a1a:	00001517          	auipc	a0,0x1
     a1e:	b2e50513          	addi	a0,a0,-1234 # 1548 <malloc+0x1ca>
     a22:	fffff097          	auipc	ra,0xfffff
     a26:	632080e7          	jalr	1586(ra) # 54 <panic>
    panic("syntax - missing )");
     a2a:	00001517          	auipc	a0,0x1
     a2e:	b3650513          	addi	a0,a0,-1226 # 1560 <malloc+0x1e2>
     a32:	fffff097          	auipc	ra,0xfffff
     a36:	622080e7          	jalr	1570(ra) # 54 <panic>

0000000000000a3a <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a3a:	1101                	addi	sp,sp,-32
     a3c:	ec06                	sd	ra,24(sp)
     a3e:	e822                	sd	s0,16(sp)
     a40:	e426                	sd	s1,8(sp)
     a42:	1000                	addi	s0,sp,32
     a44:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a46:	c521                	beqz	a0,a8e <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     a48:	4118                	lw	a4,0(a0)
     a4a:	4795                	li	a5,5
     a4c:	04e7e163          	bltu	a5,a4,a8e <nulterminate+0x54>
     a50:	00056783          	lwu	a5,0(a0)
     a54:	078a                	slli	a5,a5,0x2
     a56:	00001717          	auipc	a4,0x1
     a5a:	b6a70713          	addi	a4,a4,-1174 # 15c0 <malloc+0x242>
     a5e:	97ba                	add	a5,a5,a4
     a60:	439c                	lw	a5,0(a5)
     a62:	97ba                	add	a5,a5,a4
     a64:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a66:	651c                	ld	a5,8(a0)
     a68:	c39d                	beqz	a5,a8e <nulterminate+0x54>
     a6a:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     a6e:	67b8                	ld	a4,72(a5)
     a70:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     a74:	07a1                	addi	a5,a5,8
     a76:	ff87b703          	ld	a4,-8(a5)
     a7a:	fb75                	bnez	a4,a6e <nulterminate+0x34>
     a7c:	a809                	j	a8e <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     a7e:	6508                	ld	a0,8(a0)
     a80:	00000097          	auipc	ra,0x0
     a84:	fba080e7          	jalr	-70(ra) # a3a <nulterminate>
    *rcmd->efile = 0;
     a88:	6c9c                	ld	a5,24(s1)
     a8a:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a8e:	8526                	mv	a0,s1
     a90:	60e2                	ld	ra,24(sp)
     a92:	6442                	ld	s0,16(sp)
     a94:	64a2                	ld	s1,8(sp)
     a96:	6105                	addi	sp,sp,32
     a98:	8082                	ret
    nulterminate(pcmd->left);
     a9a:	6508                	ld	a0,8(a0)
     a9c:	00000097          	auipc	ra,0x0
     aa0:	f9e080e7          	jalr	-98(ra) # a3a <nulterminate>
    nulterminate(pcmd->right);
     aa4:	6888                	ld	a0,16(s1)
     aa6:	00000097          	auipc	ra,0x0
     aaa:	f94080e7          	jalr	-108(ra) # a3a <nulterminate>
    break;
     aae:	b7c5                	j	a8e <nulterminate+0x54>
    nulterminate(lcmd->left);
     ab0:	6508                	ld	a0,8(a0)
     ab2:	00000097          	auipc	ra,0x0
     ab6:	f88080e7          	jalr	-120(ra) # a3a <nulterminate>
    nulterminate(lcmd->right);
     aba:	6888                	ld	a0,16(s1)
     abc:	00000097          	auipc	ra,0x0
     ac0:	f7e080e7          	jalr	-130(ra) # a3a <nulterminate>
    break;
     ac4:	b7e9                	j	a8e <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     ac6:	6508                	ld	a0,8(a0)
     ac8:	00000097          	auipc	ra,0x0
     acc:	f72080e7          	jalr	-142(ra) # a3a <nulterminate>
    break;
     ad0:	bf7d                	j	a8e <nulterminate+0x54>

0000000000000ad2 <parsecmd>:
{
     ad2:	7179                	addi	sp,sp,-48
     ad4:	f406                	sd	ra,40(sp)
     ad6:	f022                	sd	s0,32(sp)
     ad8:	ec26                	sd	s1,24(sp)
     ada:	e84a                	sd	s2,16(sp)
     adc:	1800                	addi	s0,sp,48
     ade:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     ae2:	84aa                	mv	s1,a0
     ae4:	00000097          	auipc	ra,0x0
     ae8:	1b2080e7          	jalr	434(ra) # c96 <strlen>
     aec:	1502                	slli	a0,a0,0x20
     aee:	9101                	srli	a0,a0,0x20
     af0:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     af2:	85a6                	mv	a1,s1
     af4:	fd840513          	addi	a0,s0,-40
     af8:	00000097          	auipc	ra,0x0
     afc:	df6080e7          	jalr	-522(ra) # 8ee <parseline>
     b00:	892a                	mv	s2,a0
  peek(&s, es, "");
     b02:	00001617          	auipc	a2,0x1
     b06:	a7660613          	addi	a2,a2,-1418 # 1578 <malloc+0x1fa>
     b0a:	85a6                	mv	a1,s1
     b0c:	fd840513          	addi	a0,s0,-40
     b10:	00000097          	auipc	ra,0x0
     b14:	b00080e7          	jalr	-1280(ra) # 610 <peek>
  if(s != es){
     b18:	fd843603          	ld	a2,-40(s0)
     b1c:	00961e63          	bne	a2,s1,b38 <parsecmd+0x66>
  nulterminate(cmd);
     b20:	854a                	mv	a0,s2
     b22:	00000097          	auipc	ra,0x0
     b26:	f18080e7          	jalr	-232(ra) # a3a <nulterminate>
}
     b2a:	854a                	mv	a0,s2
     b2c:	70a2                	ld	ra,40(sp)
     b2e:	7402                	ld	s0,32(sp)
     b30:	64e2                	ld	s1,24(sp)
     b32:	6942                	ld	s2,16(sp)
     b34:	6145                	addi	sp,sp,48
     b36:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     b38:	00001597          	auipc	a1,0x1
     b3c:	a4858593          	addi	a1,a1,-1464 # 1580 <malloc+0x202>
     b40:	4509                	li	a0,2
     b42:	00000097          	auipc	ra,0x0
     b46:	756080e7          	jalr	1878(ra) # 1298 <fprintf>
    panic("syntax");
     b4a:	00001517          	auipc	a0,0x1
     b4e:	9c650513          	addi	a0,a0,-1594 # 1510 <malloc+0x192>
     b52:	fffff097          	auipc	ra,0xfffff
     b56:	502080e7          	jalr	1282(ra) # 54 <panic>

0000000000000b5a <main>:
{
     b5a:	7139                	addi	sp,sp,-64
     b5c:	fc06                	sd	ra,56(sp)
     b5e:	f822                	sd	s0,48(sp)
     b60:	f426                	sd	s1,40(sp)
     b62:	f04a                	sd	s2,32(sp)
     b64:	ec4e                	sd	s3,24(sp)
     b66:	e852                	sd	s4,16(sp)
     b68:	e456                	sd	s5,8(sp)
     b6a:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     b6c:	00001497          	auipc	s1,0x1
     b70:	a2448493          	addi	s1,s1,-1500 # 1590 <malloc+0x212>
     b74:	4589                	li	a1,2
     b76:	8526                	mv	a0,s1
     b78:	00000097          	auipc	ra,0x0
     b7c:	414080e7          	jalr	1044(ra) # f8c <open>
     b80:	00054963          	bltz	a0,b92 <main+0x38>
    if(fd >= 3){
     b84:	4789                	li	a5,2
     b86:	fea7d7e3          	bge	a5,a0,b74 <main+0x1a>
      close(fd);
     b8a:	00000097          	auipc	ra,0x0
     b8e:	3ea080e7          	jalr	1002(ra) # f74 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     b92:	00001497          	auipc	s1,0x1
     b96:	ad648493          	addi	s1,s1,-1322 # 1668 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b9a:	06300913          	li	s2,99
     b9e:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     ba2:	00001a17          	auipc	s4,0x1
     ba6:	ac9a0a13          	addi	s4,s4,-1335 # 166b <buf.0+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     baa:	00001a97          	auipc	s5,0x1
     bae:	9eea8a93          	addi	s5,s5,-1554 # 1598 <malloc+0x21a>
     bb2:	a819                	j	bc8 <main+0x6e>
    if(fork1() == 0)
     bb4:	fffff097          	auipc	ra,0xfffff
     bb8:	4c6080e7          	jalr	1222(ra) # 7a <fork1>
     bbc:	c925                	beqz	a0,c2c <main+0xd2>
    wait(0);
     bbe:	4501                	li	a0,0
     bc0:	00000097          	auipc	ra,0x0
     bc4:	394080e7          	jalr	916(ra) # f54 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     bc8:	06400593          	li	a1,100
     bcc:	8526                	mv	a0,s1
     bce:	fffff097          	auipc	ra,0xfffff
     bd2:	432080e7          	jalr	1074(ra) # 0 <getcmd>
     bd6:	06054763          	bltz	a0,c44 <main+0xea>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     bda:	0004c783          	lbu	a5,0(s1)
     bde:	fd279be3          	bne	a5,s2,bb4 <main+0x5a>
     be2:	0014c703          	lbu	a4,1(s1)
     be6:	06400793          	li	a5,100
     bea:	fcf715e3          	bne	a4,a5,bb4 <main+0x5a>
     bee:	0024c783          	lbu	a5,2(s1)
     bf2:	fd3791e3          	bne	a5,s3,bb4 <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
     bf6:	8526                	mv	a0,s1
     bf8:	00000097          	auipc	ra,0x0
     bfc:	09e080e7          	jalr	158(ra) # c96 <strlen>
     c00:	fff5079b          	addiw	a5,a0,-1
     c04:	1782                	slli	a5,a5,0x20
     c06:	9381                	srli	a5,a5,0x20
     c08:	97a6                	add	a5,a5,s1
     c0a:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     c0e:	8552                	mv	a0,s4
     c10:	00000097          	auipc	ra,0x0
     c14:	3ac080e7          	jalr	940(ra) # fbc <chdir>
     c18:	fa0558e3          	bgez	a0,bc8 <main+0x6e>
        fprintf(2, "cannot cd %s\n", buf+3);
     c1c:	8652                	mv	a2,s4
     c1e:	85d6                	mv	a1,s5
     c20:	4509                	li	a0,2
     c22:	00000097          	auipc	ra,0x0
     c26:	676080e7          	jalr	1654(ra) # 1298 <fprintf>
     c2a:	bf79                	j	bc8 <main+0x6e>
      runcmd(parsecmd(buf));
     c2c:	00001517          	auipc	a0,0x1
     c30:	a3c50513          	addi	a0,a0,-1476 # 1668 <buf.0>
     c34:	00000097          	auipc	ra,0x0
     c38:	e9e080e7          	jalr	-354(ra) # ad2 <parsecmd>
     c3c:	fffff097          	auipc	ra,0xfffff
     c40:	46c080e7          	jalr	1132(ra) # a8 <runcmd>
  exit(0);
     c44:	4501                	li	a0,0
     c46:	00000097          	auipc	ra,0x0
     c4a:	306080e7          	jalr	774(ra) # f4c <exit>

0000000000000c4e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     c4e:	1141                	addi	sp,sp,-16
     c50:	e422                	sd	s0,8(sp)
     c52:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c54:	87aa                	mv	a5,a0
     c56:	0585                	addi	a1,a1,1
     c58:	0785                	addi	a5,a5,1
     c5a:	fff5c703          	lbu	a4,-1(a1)
     c5e:	fee78fa3          	sb	a4,-1(a5)
     c62:	fb75                	bnez	a4,c56 <strcpy+0x8>
    ;
  return os;
}
     c64:	6422                	ld	s0,8(sp)
     c66:	0141                	addi	sp,sp,16
     c68:	8082                	ret

0000000000000c6a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c6a:	1141                	addi	sp,sp,-16
     c6c:	e422                	sd	s0,8(sp)
     c6e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     c70:	00054783          	lbu	a5,0(a0)
     c74:	cb91                	beqz	a5,c88 <strcmp+0x1e>
     c76:	0005c703          	lbu	a4,0(a1)
     c7a:	00f71763          	bne	a4,a5,c88 <strcmp+0x1e>
    p++, q++;
     c7e:	0505                	addi	a0,a0,1
     c80:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     c82:	00054783          	lbu	a5,0(a0)
     c86:	fbe5                	bnez	a5,c76 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     c88:	0005c503          	lbu	a0,0(a1)
}
     c8c:	40a7853b          	subw	a0,a5,a0
     c90:	6422                	ld	s0,8(sp)
     c92:	0141                	addi	sp,sp,16
     c94:	8082                	ret

0000000000000c96 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
     c96:	1141                	addi	sp,sp,-16
     c98:	e422                	sd	s0,8(sp)
     c9a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c9c:	00054783          	lbu	a5,0(a0)
     ca0:	cf91                	beqz	a5,cbc <strlen+0x26>
     ca2:	0505                	addi	a0,a0,1
     ca4:	87aa                	mv	a5,a0
     ca6:	4685                	li	a3,1
     ca8:	9e89                	subw	a3,a3,a0
     caa:	00f6853b          	addw	a0,a3,a5
     cae:	0785                	addi	a5,a5,1
     cb0:	fff7c703          	lbu	a4,-1(a5)
     cb4:	fb7d                	bnez	a4,caa <strlen+0x14>
    ;
  return n;
}
     cb6:	6422                	ld	s0,8(sp)
     cb8:	0141                	addi	sp,sp,16
     cba:	8082                	ret
  for(n = 0; s[n]; n++)
     cbc:	4501                	li	a0,0
     cbe:	bfe5                	j	cb6 <strlen+0x20>

0000000000000cc0 <strsub>:
int strsub(const char *s, const char *sub){
     cc0:	7139                	addi	sp,sp,-64
     cc2:	fc06                	sd	ra,56(sp)
     cc4:	f822                	sd	s0,48(sp)
     cc6:	f426                	sd	s1,40(sp)
     cc8:	f04a                	sd	s2,32(sp)
     cca:	ec4e                	sd	s3,24(sp)
     ccc:	e852                	sd	s4,16(sp)
     cce:	e456                	sd	s5,8(sp)
     cd0:	0080                	addi	s0,sp,64
     cd2:	8a2a                	mv	s4,a0
     cd4:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
     cd6:	84aa                	mv	s1,a0
     cd8:	4901                	li	s2,0
     cda:	a019                	j	ce0 <strsub+0x20>
     cdc:	2905                	addiw	s2,s2,1
     cde:	0485                	addi	s1,s1,1
     ce0:	8552                	mv	a0,s4
     ce2:	00000097          	auipc	ra,0x0
     ce6:	fb4080e7          	jalr	-76(ra) # c96 <strlen>
     cea:	2501                	sext.w	a0,a0
     cec:	04a97863          	bgeu	s2,a0,d3c <strsub+0x7c>
    if(s[i] == sub[0]){
     cf0:	8aa6                	mv	s5,s1
     cf2:	0004c703          	lbu	a4,0(s1)
     cf6:	0009c783          	lbu	a5,0(s3)
     cfa:	fef711e3          	bne	a4,a5,cdc <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
     cfe:	854e                	mv	a0,s3
     d00:	00000097          	auipc	ra,0x0
     d04:	f96080e7          	jalr	-106(ra) # c96 <strlen>
     d08:	0005059b          	sext.w	a1,a0
     d0c:	ffe5061b          	addiw	a2,a0,-2
     d10:	1602                	slli	a2,a2,0x20
     d12:	9201                	srli	a2,a2,0x20
     d14:	0609                	addi	a2,a2,2
     d16:	4785                	li	a5,1
     d18:	0007871b          	sext.w	a4,a5
     d1c:	fcb770e3          	bgeu	a4,a1,cdc <strsub+0x1c>
        if(s[j+i] != sub[j]){
     d20:	00fa86b3          	add	a3,s5,a5
     d24:	00f98733          	add	a4,s3,a5
     d28:	0006c683          	lbu	a3,0(a3)
     d2c:	00074703          	lbu	a4,0(a4)
     d30:	fae696e3          	bne	a3,a4,cdc <strsub+0x1c>
        if(j == strlen(sub) -1){
     d34:	0785                	addi	a5,a5,1
     d36:	fec791e3          	bne	a5,a2,d18 <strsub+0x58>
     d3a:	a011                	j	d3e <strsub+0x7e>
  return -1;
     d3c:	597d                	li	s2,-1
}
     d3e:	854a                	mv	a0,s2
     d40:	70e2                	ld	ra,56(sp)
     d42:	7442                	ld	s0,48(sp)
     d44:	74a2                	ld	s1,40(sp)
     d46:	7902                	ld	s2,32(sp)
     d48:	69e2                	ld	s3,24(sp)
     d4a:	6a42                	ld	s4,16(sp)
     d4c:	6aa2                	ld	s5,8(sp)
     d4e:	6121                	addi	sp,sp,64
     d50:	8082                	ret

0000000000000d52 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d52:	1141                	addi	sp,sp,-16
     d54:	e422                	sd	s0,8(sp)
     d56:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     d58:	ca19                	beqz	a2,d6e <memset+0x1c>
     d5a:	87aa                	mv	a5,a0
     d5c:	1602                	slli	a2,a2,0x20
     d5e:	9201                	srli	a2,a2,0x20
     d60:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     d64:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     d68:	0785                	addi	a5,a5,1
     d6a:	fee79de3          	bne	a5,a4,d64 <memset+0x12>
  }
  return dst;
}
     d6e:	6422                	ld	s0,8(sp)
     d70:	0141                	addi	sp,sp,16
     d72:	8082                	ret

0000000000000d74 <strchr>:

char*
strchr(const char *s, char c)
{
     d74:	1141                	addi	sp,sp,-16
     d76:	e422                	sd	s0,8(sp)
     d78:	0800                	addi	s0,sp,16
  for(; *s; s++)
     d7a:	00054783          	lbu	a5,0(a0)
     d7e:	cb99                	beqz	a5,d94 <strchr+0x20>
    if(*s == c)
     d80:	00f58763          	beq	a1,a5,d8e <strchr+0x1a>
  for(; *s; s++)
     d84:	0505                	addi	a0,a0,1
     d86:	00054783          	lbu	a5,0(a0)
     d8a:	fbfd                	bnez	a5,d80 <strchr+0xc>
      return (char*)s;
  return 0;
     d8c:	4501                	li	a0,0
}
     d8e:	6422                	ld	s0,8(sp)
     d90:	0141                	addi	sp,sp,16
     d92:	8082                	ret
  return 0;
     d94:	4501                	li	a0,0
     d96:	bfe5                	j	d8e <strchr+0x1a>

0000000000000d98 <gets>:

char*
gets(char *buf, int max)
{
     d98:	711d                	addi	sp,sp,-96
     d9a:	ec86                	sd	ra,88(sp)
     d9c:	e8a2                	sd	s0,80(sp)
     d9e:	e4a6                	sd	s1,72(sp)
     da0:	e0ca                	sd	s2,64(sp)
     da2:	fc4e                	sd	s3,56(sp)
     da4:	f852                	sd	s4,48(sp)
     da6:	f456                	sd	s5,40(sp)
     da8:	f05a                	sd	s6,32(sp)
     daa:	ec5e                	sd	s7,24(sp)
     dac:	1080                	addi	s0,sp,96
     dae:	8baa                	mv	s7,a0
     db0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     db2:	892a                	mv	s2,a0
     db4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     db6:	4aa9                	li	s5,10
     db8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     dba:	89a6                	mv	s3,s1
     dbc:	2485                	addiw	s1,s1,1
     dbe:	0344d863          	bge	s1,s4,dee <gets+0x56>
    cc = read(0, &c, 1);
     dc2:	4605                	li	a2,1
     dc4:	faf40593          	addi	a1,s0,-81
     dc8:	4501                	li	a0,0
     dca:	00000097          	auipc	ra,0x0
     dce:	19a080e7          	jalr	410(ra) # f64 <read>
    if(cc < 1)
     dd2:	00a05e63          	blez	a0,dee <gets+0x56>
    buf[i++] = c;
     dd6:	faf44783          	lbu	a5,-81(s0)
     dda:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     dde:	01578763          	beq	a5,s5,dec <gets+0x54>
     de2:	0905                	addi	s2,s2,1
     de4:	fd679be3          	bne	a5,s6,dba <gets+0x22>
  for(i=0; i+1 < max; ){
     de8:	89a6                	mv	s3,s1
     dea:	a011                	j	dee <gets+0x56>
     dec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     dee:	99de                	add	s3,s3,s7
     df0:	00098023          	sb	zero,0(s3)
  return buf;
}
     df4:	855e                	mv	a0,s7
     df6:	60e6                	ld	ra,88(sp)
     df8:	6446                	ld	s0,80(sp)
     dfa:	64a6                	ld	s1,72(sp)
     dfc:	6906                	ld	s2,64(sp)
     dfe:	79e2                	ld	s3,56(sp)
     e00:	7a42                	ld	s4,48(sp)
     e02:	7aa2                	ld	s5,40(sp)
     e04:	7b02                	ld	s6,32(sp)
     e06:	6be2                	ld	s7,24(sp)
     e08:	6125                	addi	sp,sp,96
     e0a:	8082                	ret

0000000000000e0c <stat>:

int
stat(const char *n, struct stat *st)
{
     e0c:	1101                	addi	sp,sp,-32
     e0e:	ec06                	sd	ra,24(sp)
     e10:	e822                	sd	s0,16(sp)
     e12:	e426                	sd	s1,8(sp)
     e14:	e04a                	sd	s2,0(sp)
     e16:	1000                	addi	s0,sp,32
     e18:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e1a:	4581                	li	a1,0
     e1c:	00000097          	auipc	ra,0x0
     e20:	170080e7          	jalr	368(ra) # f8c <open>
  if(fd < 0)
     e24:	02054563          	bltz	a0,e4e <stat+0x42>
     e28:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     e2a:	85ca                	mv	a1,s2
     e2c:	00000097          	auipc	ra,0x0
     e30:	178080e7          	jalr	376(ra) # fa4 <fstat>
     e34:	892a                	mv	s2,a0
  close(fd);
     e36:	8526                	mv	a0,s1
     e38:	00000097          	auipc	ra,0x0
     e3c:	13c080e7          	jalr	316(ra) # f74 <close>
  return r;
}
     e40:	854a                	mv	a0,s2
     e42:	60e2                	ld	ra,24(sp)
     e44:	6442                	ld	s0,16(sp)
     e46:	64a2                	ld	s1,8(sp)
     e48:	6902                	ld	s2,0(sp)
     e4a:	6105                	addi	sp,sp,32
     e4c:	8082                	ret
    return -1;
     e4e:	597d                	li	s2,-1
     e50:	bfc5                	j	e40 <stat+0x34>

0000000000000e52 <atoi>:

int
atoi(const char *s)
{
     e52:	1141                	addi	sp,sp,-16
     e54:	e422                	sd	s0,8(sp)
     e56:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e58:	00054683          	lbu	a3,0(a0)
     e5c:	fd06879b          	addiw	a5,a3,-48
     e60:	0ff7f793          	zext.b	a5,a5
     e64:	4625                	li	a2,9
     e66:	02f66863          	bltu	a2,a5,e96 <atoi+0x44>
     e6a:	872a                	mv	a4,a0
  n = 0;
     e6c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     e6e:	0705                	addi	a4,a4,1
     e70:	0025179b          	slliw	a5,a0,0x2
     e74:	9fa9                	addw	a5,a5,a0
     e76:	0017979b          	slliw	a5,a5,0x1
     e7a:	9fb5                	addw	a5,a5,a3
     e7c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e80:	00074683          	lbu	a3,0(a4)
     e84:	fd06879b          	addiw	a5,a3,-48
     e88:	0ff7f793          	zext.b	a5,a5
     e8c:	fef671e3          	bgeu	a2,a5,e6e <atoi+0x1c>
  return n;
}
     e90:	6422                	ld	s0,8(sp)
     e92:	0141                	addi	sp,sp,16
     e94:	8082                	ret
  n = 0;
     e96:	4501                	li	a0,0
     e98:	bfe5                	j	e90 <atoi+0x3e>

0000000000000e9a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e9a:	1141                	addi	sp,sp,-16
     e9c:	e422                	sd	s0,8(sp)
     e9e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     ea0:	02b57463          	bgeu	a0,a1,ec8 <memmove+0x2e>
    while(n-- > 0)
     ea4:	00c05f63          	blez	a2,ec2 <memmove+0x28>
     ea8:	1602                	slli	a2,a2,0x20
     eaa:	9201                	srli	a2,a2,0x20
     eac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     eb0:	872a                	mv	a4,a0
      *dst++ = *src++;
     eb2:	0585                	addi	a1,a1,1
     eb4:	0705                	addi	a4,a4,1
     eb6:	fff5c683          	lbu	a3,-1(a1)
     eba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ebe:	fee79ae3          	bne	a5,a4,eb2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ec2:	6422                	ld	s0,8(sp)
     ec4:	0141                	addi	sp,sp,16
     ec6:	8082                	ret
    dst += n;
     ec8:	00c50733          	add	a4,a0,a2
    src += n;
     ecc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ece:	fec05ae3          	blez	a2,ec2 <memmove+0x28>
     ed2:	fff6079b          	addiw	a5,a2,-1
     ed6:	1782                	slli	a5,a5,0x20
     ed8:	9381                	srli	a5,a5,0x20
     eda:	fff7c793          	not	a5,a5
     ede:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ee0:	15fd                	addi	a1,a1,-1
     ee2:	177d                	addi	a4,a4,-1
     ee4:	0005c683          	lbu	a3,0(a1)
     ee8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     eec:	fee79ae3          	bne	a5,a4,ee0 <memmove+0x46>
     ef0:	bfc9                	j	ec2 <memmove+0x28>

0000000000000ef2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     ef2:	1141                	addi	sp,sp,-16
     ef4:	e422                	sd	s0,8(sp)
     ef6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     ef8:	ca05                	beqz	a2,f28 <memcmp+0x36>
     efa:	fff6069b          	addiw	a3,a2,-1
     efe:	1682                	slli	a3,a3,0x20
     f00:	9281                	srli	a3,a3,0x20
     f02:	0685                	addi	a3,a3,1
     f04:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     f06:	00054783          	lbu	a5,0(a0)
     f0a:	0005c703          	lbu	a4,0(a1)
     f0e:	00e79863          	bne	a5,a4,f1e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     f12:	0505                	addi	a0,a0,1
    p2++;
     f14:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     f16:	fed518e3          	bne	a0,a3,f06 <memcmp+0x14>
  }
  return 0;
     f1a:	4501                	li	a0,0
     f1c:	a019                	j	f22 <memcmp+0x30>
      return *p1 - *p2;
     f1e:	40e7853b          	subw	a0,a5,a4
}
     f22:	6422                	ld	s0,8(sp)
     f24:	0141                	addi	sp,sp,16
     f26:	8082                	ret
  return 0;
     f28:	4501                	li	a0,0
     f2a:	bfe5                	j	f22 <memcmp+0x30>

0000000000000f2c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     f2c:	1141                	addi	sp,sp,-16
     f2e:	e406                	sd	ra,8(sp)
     f30:	e022                	sd	s0,0(sp)
     f32:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     f34:	00000097          	auipc	ra,0x0
     f38:	f66080e7          	jalr	-154(ra) # e9a <memmove>
}
     f3c:	60a2                	ld	ra,8(sp)
     f3e:	6402                	ld	s0,0(sp)
     f40:	0141                	addi	sp,sp,16
     f42:	8082                	ret

0000000000000f44 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     f44:	4885                	li	a7,1
 ecall
     f46:	00000073          	ecall
 ret
     f4a:	8082                	ret

0000000000000f4c <exit>:
.global exit
exit:
 li a7, SYS_exit
     f4c:	4889                	li	a7,2
 ecall
     f4e:	00000073          	ecall
 ret
     f52:	8082                	ret

0000000000000f54 <wait>:
.global wait
wait:
 li a7, SYS_wait
     f54:	488d                	li	a7,3
 ecall
     f56:	00000073          	ecall
 ret
     f5a:	8082                	ret

0000000000000f5c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f5c:	4891                	li	a7,4
 ecall
     f5e:	00000073          	ecall
 ret
     f62:	8082                	ret

0000000000000f64 <read>:
.global read
read:
 li a7, SYS_read
     f64:	4895                	li	a7,5
 ecall
     f66:	00000073          	ecall
 ret
     f6a:	8082                	ret

0000000000000f6c <write>:
.global write
write:
 li a7, SYS_write
     f6c:	48c1                	li	a7,16
 ecall
     f6e:	00000073          	ecall
 ret
     f72:	8082                	ret

0000000000000f74 <close>:
.global close
close:
 li a7, SYS_close
     f74:	48d5                	li	a7,21
 ecall
     f76:	00000073          	ecall
 ret
     f7a:	8082                	ret

0000000000000f7c <kill>:
.global kill
kill:
 li a7, SYS_kill
     f7c:	4899                	li	a7,6
 ecall
     f7e:	00000073          	ecall
 ret
     f82:	8082                	ret

0000000000000f84 <exec>:
.global exec
exec:
 li a7, SYS_exec
     f84:	489d                	li	a7,7
 ecall
     f86:	00000073          	ecall
 ret
     f8a:	8082                	ret

0000000000000f8c <open>:
.global open
open:
 li a7, SYS_open
     f8c:	48bd                	li	a7,15
 ecall
     f8e:	00000073          	ecall
 ret
     f92:	8082                	ret

0000000000000f94 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     f94:	48c5                	li	a7,17
 ecall
     f96:	00000073          	ecall
 ret
     f9a:	8082                	ret

0000000000000f9c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     f9c:	48c9                	li	a7,18
 ecall
     f9e:	00000073          	ecall
 ret
     fa2:	8082                	ret

0000000000000fa4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     fa4:	48a1                	li	a7,8
 ecall
     fa6:	00000073          	ecall
 ret
     faa:	8082                	ret

0000000000000fac <link>:
.global link
link:
 li a7, SYS_link
     fac:	48cd                	li	a7,19
 ecall
     fae:	00000073          	ecall
 ret
     fb2:	8082                	ret

0000000000000fb4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     fb4:	48d1                	li	a7,20
 ecall
     fb6:	00000073          	ecall
 ret
     fba:	8082                	ret

0000000000000fbc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     fbc:	48a5                	li	a7,9
 ecall
     fbe:	00000073          	ecall
 ret
     fc2:	8082                	ret

0000000000000fc4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     fc4:	48a9                	li	a7,10
 ecall
     fc6:	00000073          	ecall
 ret
     fca:	8082                	ret

0000000000000fcc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     fcc:	48ad                	li	a7,11
 ecall
     fce:	00000073          	ecall
 ret
     fd2:	8082                	ret

0000000000000fd4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     fd4:	48b1                	li	a7,12
 ecall
     fd6:	00000073          	ecall
 ret
     fda:	8082                	ret

0000000000000fdc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     fdc:	48b5                	li	a7,13
 ecall
     fde:	00000073          	ecall
 ret
     fe2:	8082                	ret

0000000000000fe4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     fe4:	48b9                	li	a7,14
 ecall
     fe6:	00000073          	ecall
 ret
     fea:	8082                	ret

0000000000000fec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     fec:	1101                	addi	sp,sp,-32
     fee:	ec06                	sd	ra,24(sp)
     ff0:	e822                	sd	s0,16(sp)
     ff2:	1000                	addi	s0,sp,32
     ff4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ff8:	4605                	li	a2,1
     ffa:	fef40593          	addi	a1,s0,-17
     ffe:	00000097          	auipc	ra,0x0
    1002:	f6e080e7          	jalr	-146(ra) # f6c <write>
}
    1006:	60e2                	ld	ra,24(sp)
    1008:	6442                	ld	s0,16(sp)
    100a:	6105                	addi	sp,sp,32
    100c:	8082                	ret

000000000000100e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    100e:	7139                	addi	sp,sp,-64
    1010:	fc06                	sd	ra,56(sp)
    1012:	f822                	sd	s0,48(sp)
    1014:	f426                	sd	s1,40(sp)
    1016:	f04a                	sd	s2,32(sp)
    1018:	ec4e                	sd	s3,24(sp)
    101a:	0080                	addi	s0,sp,64
    101c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    101e:	c299                	beqz	a3,1024 <printint+0x16>
    1020:	0805c963          	bltz	a1,10b2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1024:	2581                	sext.w	a1,a1
  neg = 0;
    1026:	4881                	li	a7,0
    1028:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    102c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    102e:	2601                	sext.w	a2,a2
    1030:	00000517          	auipc	a0,0x0
    1034:	60850513          	addi	a0,a0,1544 # 1638 <digits>
    1038:	883a                	mv	a6,a4
    103a:	2705                	addiw	a4,a4,1
    103c:	02c5f7bb          	remuw	a5,a1,a2
    1040:	1782                	slli	a5,a5,0x20
    1042:	9381                	srli	a5,a5,0x20
    1044:	97aa                	add	a5,a5,a0
    1046:	0007c783          	lbu	a5,0(a5)
    104a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    104e:	0005879b          	sext.w	a5,a1
    1052:	02c5d5bb          	divuw	a1,a1,a2
    1056:	0685                	addi	a3,a3,1
    1058:	fec7f0e3          	bgeu	a5,a2,1038 <printint+0x2a>
  if(neg)
    105c:	00088c63          	beqz	a7,1074 <printint+0x66>
    buf[i++] = '-';
    1060:	fd070793          	addi	a5,a4,-48
    1064:	00878733          	add	a4,a5,s0
    1068:	02d00793          	li	a5,45
    106c:	fef70823          	sb	a5,-16(a4)
    1070:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1074:	02e05863          	blez	a4,10a4 <printint+0x96>
    1078:	fc040793          	addi	a5,s0,-64
    107c:	00e78933          	add	s2,a5,a4
    1080:	fff78993          	addi	s3,a5,-1
    1084:	99ba                	add	s3,s3,a4
    1086:	377d                	addiw	a4,a4,-1
    1088:	1702                	slli	a4,a4,0x20
    108a:	9301                	srli	a4,a4,0x20
    108c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1090:	fff94583          	lbu	a1,-1(s2)
    1094:	8526                	mv	a0,s1
    1096:	00000097          	auipc	ra,0x0
    109a:	f56080e7          	jalr	-170(ra) # fec <putc>
  while(--i >= 0)
    109e:	197d                	addi	s2,s2,-1
    10a0:	ff3918e3          	bne	s2,s3,1090 <printint+0x82>
}
    10a4:	70e2                	ld	ra,56(sp)
    10a6:	7442                	ld	s0,48(sp)
    10a8:	74a2                	ld	s1,40(sp)
    10aa:	7902                	ld	s2,32(sp)
    10ac:	69e2                	ld	s3,24(sp)
    10ae:	6121                	addi	sp,sp,64
    10b0:	8082                	ret
    x = -xx;
    10b2:	40b005bb          	negw	a1,a1
    neg = 1;
    10b6:	4885                	li	a7,1
    x = -xx;
    10b8:	bf85                	j	1028 <printint+0x1a>

00000000000010ba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    10ba:	7119                	addi	sp,sp,-128
    10bc:	fc86                	sd	ra,120(sp)
    10be:	f8a2                	sd	s0,112(sp)
    10c0:	f4a6                	sd	s1,104(sp)
    10c2:	f0ca                	sd	s2,96(sp)
    10c4:	ecce                	sd	s3,88(sp)
    10c6:	e8d2                	sd	s4,80(sp)
    10c8:	e4d6                	sd	s5,72(sp)
    10ca:	e0da                	sd	s6,64(sp)
    10cc:	fc5e                	sd	s7,56(sp)
    10ce:	f862                	sd	s8,48(sp)
    10d0:	f466                	sd	s9,40(sp)
    10d2:	f06a                	sd	s10,32(sp)
    10d4:	ec6e                	sd	s11,24(sp)
    10d6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    10d8:	0005c903          	lbu	s2,0(a1)
    10dc:	18090f63          	beqz	s2,127a <vprintf+0x1c0>
    10e0:	8aaa                	mv	s5,a0
    10e2:	8b32                	mv	s6,a2
    10e4:	00158493          	addi	s1,a1,1
  state = 0;
    10e8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    10ea:	02500a13          	li	s4,37
    10ee:	4c55                	li	s8,21
    10f0:	00000c97          	auipc	s9,0x0
    10f4:	4f0c8c93          	addi	s9,s9,1264 # 15e0 <malloc+0x262>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    10f8:	02800d93          	li	s11,40
  putc(fd, 'x');
    10fc:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10fe:	00000b97          	auipc	s7,0x0
    1102:	53ab8b93          	addi	s7,s7,1338 # 1638 <digits>
    1106:	a839                	j	1124 <vprintf+0x6a>
        putc(fd, c);
    1108:	85ca                	mv	a1,s2
    110a:	8556                	mv	a0,s5
    110c:	00000097          	auipc	ra,0x0
    1110:	ee0080e7          	jalr	-288(ra) # fec <putc>
    1114:	a019                	j	111a <vprintf+0x60>
    } else if(state == '%'){
    1116:	01498d63          	beq	s3,s4,1130 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    111a:	0485                	addi	s1,s1,1
    111c:	fff4c903          	lbu	s2,-1(s1)
    1120:	14090d63          	beqz	s2,127a <vprintf+0x1c0>
    if(state == 0){
    1124:	fe0999e3          	bnez	s3,1116 <vprintf+0x5c>
      if(c == '%'){
    1128:	ff4910e3          	bne	s2,s4,1108 <vprintf+0x4e>
        state = '%';
    112c:	89d2                	mv	s3,s4
    112e:	b7f5                	j	111a <vprintf+0x60>
      if(c == 'd'){
    1130:	11490c63          	beq	s2,s4,1248 <vprintf+0x18e>
    1134:	f9d9079b          	addiw	a5,s2,-99
    1138:	0ff7f793          	zext.b	a5,a5
    113c:	10fc6e63          	bltu	s8,a5,1258 <vprintf+0x19e>
    1140:	f9d9079b          	addiw	a5,s2,-99
    1144:	0ff7f713          	zext.b	a4,a5
    1148:	10ec6863          	bltu	s8,a4,1258 <vprintf+0x19e>
    114c:	00271793          	slli	a5,a4,0x2
    1150:	97e6                	add	a5,a5,s9
    1152:	439c                	lw	a5,0(a5)
    1154:	97e6                	add	a5,a5,s9
    1156:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1158:	008b0913          	addi	s2,s6,8
    115c:	4685                	li	a3,1
    115e:	4629                	li	a2,10
    1160:	000b2583          	lw	a1,0(s6)
    1164:	8556                	mv	a0,s5
    1166:	00000097          	auipc	ra,0x0
    116a:	ea8080e7          	jalr	-344(ra) # 100e <printint>
    116e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1170:	4981                	li	s3,0
    1172:	b765                	j	111a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1174:	008b0913          	addi	s2,s6,8
    1178:	4681                	li	a3,0
    117a:	4629                	li	a2,10
    117c:	000b2583          	lw	a1,0(s6)
    1180:	8556                	mv	a0,s5
    1182:	00000097          	auipc	ra,0x0
    1186:	e8c080e7          	jalr	-372(ra) # 100e <printint>
    118a:	8b4a                	mv	s6,s2
      state = 0;
    118c:	4981                	li	s3,0
    118e:	b771                	j	111a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1190:	008b0913          	addi	s2,s6,8
    1194:	4681                	li	a3,0
    1196:	866a                	mv	a2,s10
    1198:	000b2583          	lw	a1,0(s6)
    119c:	8556                	mv	a0,s5
    119e:	00000097          	auipc	ra,0x0
    11a2:	e70080e7          	jalr	-400(ra) # 100e <printint>
    11a6:	8b4a                	mv	s6,s2
      state = 0;
    11a8:	4981                	li	s3,0
    11aa:	bf85                	j	111a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    11ac:	008b0793          	addi	a5,s6,8
    11b0:	f8f43423          	sd	a5,-120(s0)
    11b4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    11b8:	03000593          	li	a1,48
    11bc:	8556                	mv	a0,s5
    11be:	00000097          	auipc	ra,0x0
    11c2:	e2e080e7          	jalr	-466(ra) # fec <putc>
  putc(fd, 'x');
    11c6:	07800593          	li	a1,120
    11ca:	8556                	mv	a0,s5
    11cc:	00000097          	auipc	ra,0x0
    11d0:	e20080e7          	jalr	-480(ra) # fec <putc>
    11d4:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    11d6:	03c9d793          	srli	a5,s3,0x3c
    11da:	97de                	add	a5,a5,s7
    11dc:	0007c583          	lbu	a1,0(a5)
    11e0:	8556                	mv	a0,s5
    11e2:	00000097          	auipc	ra,0x0
    11e6:	e0a080e7          	jalr	-502(ra) # fec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11ea:	0992                	slli	s3,s3,0x4
    11ec:	397d                	addiw	s2,s2,-1
    11ee:	fe0914e3          	bnez	s2,11d6 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    11f2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    11f6:	4981                	li	s3,0
    11f8:	b70d                	j	111a <vprintf+0x60>
        s = va_arg(ap, char*);
    11fa:	008b0913          	addi	s2,s6,8
    11fe:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    1202:	02098163          	beqz	s3,1224 <vprintf+0x16a>
        while(*s != 0){
    1206:	0009c583          	lbu	a1,0(s3)
    120a:	c5ad                	beqz	a1,1274 <vprintf+0x1ba>
          putc(fd, *s);
    120c:	8556                	mv	a0,s5
    120e:	00000097          	auipc	ra,0x0
    1212:	dde080e7          	jalr	-546(ra) # fec <putc>
          s++;
    1216:	0985                	addi	s3,s3,1
        while(*s != 0){
    1218:	0009c583          	lbu	a1,0(s3)
    121c:	f9e5                	bnez	a1,120c <vprintf+0x152>
        s = va_arg(ap, char*);
    121e:	8b4a                	mv	s6,s2
      state = 0;
    1220:	4981                	li	s3,0
    1222:	bde5                	j	111a <vprintf+0x60>
          s = "(null)";
    1224:	00000997          	auipc	s3,0x0
    1228:	3b498993          	addi	s3,s3,948 # 15d8 <malloc+0x25a>
        while(*s != 0){
    122c:	85ee                	mv	a1,s11
    122e:	bff9                	j	120c <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    1230:	008b0913          	addi	s2,s6,8
    1234:	000b4583          	lbu	a1,0(s6)
    1238:	8556                	mv	a0,s5
    123a:	00000097          	auipc	ra,0x0
    123e:	db2080e7          	jalr	-590(ra) # fec <putc>
    1242:	8b4a                	mv	s6,s2
      state = 0;
    1244:	4981                	li	s3,0
    1246:	bdd1                	j	111a <vprintf+0x60>
        putc(fd, c);
    1248:	85d2                	mv	a1,s4
    124a:	8556                	mv	a0,s5
    124c:	00000097          	auipc	ra,0x0
    1250:	da0080e7          	jalr	-608(ra) # fec <putc>
      state = 0;
    1254:	4981                	li	s3,0
    1256:	b5d1                	j	111a <vprintf+0x60>
        putc(fd, '%');
    1258:	85d2                	mv	a1,s4
    125a:	8556                	mv	a0,s5
    125c:	00000097          	auipc	ra,0x0
    1260:	d90080e7          	jalr	-624(ra) # fec <putc>
        putc(fd, c);
    1264:	85ca                	mv	a1,s2
    1266:	8556                	mv	a0,s5
    1268:	00000097          	auipc	ra,0x0
    126c:	d84080e7          	jalr	-636(ra) # fec <putc>
      state = 0;
    1270:	4981                	li	s3,0
    1272:	b565                	j	111a <vprintf+0x60>
        s = va_arg(ap, char*);
    1274:	8b4a                	mv	s6,s2
      state = 0;
    1276:	4981                	li	s3,0
    1278:	b54d                	j	111a <vprintf+0x60>
    }
  }
}
    127a:	70e6                	ld	ra,120(sp)
    127c:	7446                	ld	s0,112(sp)
    127e:	74a6                	ld	s1,104(sp)
    1280:	7906                	ld	s2,96(sp)
    1282:	69e6                	ld	s3,88(sp)
    1284:	6a46                	ld	s4,80(sp)
    1286:	6aa6                	ld	s5,72(sp)
    1288:	6b06                	ld	s6,64(sp)
    128a:	7be2                	ld	s7,56(sp)
    128c:	7c42                	ld	s8,48(sp)
    128e:	7ca2                	ld	s9,40(sp)
    1290:	7d02                	ld	s10,32(sp)
    1292:	6de2                	ld	s11,24(sp)
    1294:	6109                	addi	sp,sp,128
    1296:	8082                	ret

0000000000001298 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1298:	715d                	addi	sp,sp,-80
    129a:	ec06                	sd	ra,24(sp)
    129c:	e822                	sd	s0,16(sp)
    129e:	1000                	addi	s0,sp,32
    12a0:	e010                	sd	a2,0(s0)
    12a2:	e414                	sd	a3,8(s0)
    12a4:	e818                	sd	a4,16(s0)
    12a6:	ec1c                	sd	a5,24(s0)
    12a8:	03043023          	sd	a6,32(s0)
    12ac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    12b0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    12b4:	8622                	mv	a2,s0
    12b6:	00000097          	auipc	ra,0x0
    12ba:	e04080e7          	jalr	-508(ra) # 10ba <vprintf>
}
    12be:	60e2                	ld	ra,24(sp)
    12c0:	6442                	ld	s0,16(sp)
    12c2:	6161                	addi	sp,sp,80
    12c4:	8082                	ret

00000000000012c6 <printf>:

void
printf(const char *fmt, ...)
{
    12c6:	711d                	addi	sp,sp,-96
    12c8:	ec06                	sd	ra,24(sp)
    12ca:	e822                	sd	s0,16(sp)
    12cc:	1000                	addi	s0,sp,32
    12ce:	e40c                	sd	a1,8(s0)
    12d0:	e810                	sd	a2,16(s0)
    12d2:	ec14                	sd	a3,24(s0)
    12d4:	f018                	sd	a4,32(s0)
    12d6:	f41c                	sd	a5,40(s0)
    12d8:	03043823          	sd	a6,48(s0)
    12dc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    12e0:	00840613          	addi	a2,s0,8
    12e4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    12e8:	85aa                	mv	a1,a0
    12ea:	4505                	li	a0,1
    12ec:	00000097          	auipc	ra,0x0
    12f0:	dce080e7          	jalr	-562(ra) # 10ba <vprintf>
}
    12f4:	60e2                	ld	ra,24(sp)
    12f6:	6442                	ld	s0,16(sp)
    12f8:	6125                	addi	sp,sp,96
    12fa:	8082                	ret

00000000000012fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12fc:	1141                	addi	sp,sp,-16
    12fe:	e422                	sd	s0,8(sp)
    1300:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1302:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1306:	00000797          	auipc	a5,0x0
    130a:	35a7b783          	ld	a5,858(a5) # 1660 <freep>
    130e:	a02d                	j	1338 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1310:	4618                	lw	a4,8(a2)
    1312:	9f2d                	addw	a4,a4,a1
    1314:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1318:	6398                	ld	a4,0(a5)
    131a:	6310                	ld	a2,0(a4)
    131c:	a83d                	j	135a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    131e:	ff852703          	lw	a4,-8(a0)
    1322:	9f31                	addw	a4,a4,a2
    1324:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1326:	ff053683          	ld	a3,-16(a0)
    132a:	a091                	j	136e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    132c:	6398                	ld	a4,0(a5)
    132e:	00e7e463          	bltu	a5,a4,1336 <free+0x3a>
    1332:	00e6ea63          	bltu	a3,a4,1346 <free+0x4a>
{
    1336:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1338:	fed7fae3          	bgeu	a5,a3,132c <free+0x30>
    133c:	6398                	ld	a4,0(a5)
    133e:	00e6e463          	bltu	a3,a4,1346 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1342:	fee7eae3          	bltu	a5,a4,1336 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1346:	ff852583          	lw	a1,-8(a0)
    134a:	6390                	ld	a2,0(a5)
    134c:	02059813          	slli	a6,a1,0x20
    1350:	01c85713          	srli	a4,a6,0x1c
    1354:	9736                	add	a4,a4,a3
    1356:	fae60de3          	beq	a2,a4,1310 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    135a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    135e:	4790                	lw	a2,8(a5)
    1360:	02061593          	slli	a1,a2,0x20
    1364:	01c5d713          	srli	a4,a1,0x1c
    1368:	973e                	add	a4,a4,a5
    136a:	fae68ae3          	beq	a3,a4,131e <free+0x22>
    p->s.ptr = bp->s.ptr;
    136e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1370:	00000717          	auipc	a4,0x0
    1374:	2ef73823          	sd	a5,752(a4) # 1660 <freep>
}
    1378:	6422                	ld	s0,8(sp)
    137a:	0141                	addi	sp,sp,16
    137c:	8082                	ret

000000000000137e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    137e:	7139                	addi	sp,sp,-64
    1380:	fc06                	sd	ra,56(sp)
    1382:	f822                	sd	s0,48(sp)
    1384:	f426                	sd	s1,40(sp)
    1386:	f04a                	sd	s2,32(sp)
    1388:	ec4e                	sd	s3,24(sp)
    138a:	e852                	sd	s4,16(sp)
    138c:	e456                	sd	s5,8(sp)
    138e:	e05a                	sd	s6,0(sp)
    1390:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1392:	02051493          	slli	s1,a0,0x20
    1396:	9081                	srli	s1,s1,0x20
    1398:	04bd                	addi	s1,s1,15
    139a:	8091                	srli	s1,s1,0x4
    139c:	0014899b          	addiw	s3,s1,1
    13a0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    13a2:	00000517          	auipc	a0,0x0
    13a6:	2be53503          	ld	a0,702(a0) # 1660 <freep>
    13aa:	c515                	beqz	a0,13d6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13ae:	4798                	lw	a4,8(a5)
    13b0:	02977f63          	bgeu	a4,s1,13ee <malloc+0x70>
    13b4:	8a4e                	mv	s4,s3
    13b6:	0009871b          	sext.w	a4,s3
    13ba:	6685                	lui	a3,0x1
    13bc:	00d77363          	bgeu	a4,a3,13c2 <malloc+0x44>
    13c0:	6a05                	lui	s4,0x1
    13c2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    13c6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13ca:	00000917          	auipc	s2,0x0
    13ce:	29690913          	addi	s2,s2,662 # 1660 <freep>
  if(p == (char*)-1)
    13d2:	5afd                	li	s5,-1
    13d4:	a895                	j	1448 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    13d6:	00000797          	auipc	a5,0x0
    13da:	2fa78793          	addi	a5,a5,762 # 16d0 <base>
    13de:	00000717          	auipc	a4,0x0
    13e2:	28f73123          	sd	a5,642(a4) # 1660 <freep>
    13e6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    13e8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    13ec:	b7e1                	j	13b4 <malloc+0x36>
      if(p->s.size == nunits)
    13ee:	02e48c63          	beq	s1,a4,1426 <malloc+0xa8>
        p->s.size -= nunits;
    13f2:	4137073b          	subw	a4,a4,s3
    13f6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13f8:	02071693          	slli	a3,a4,0x20
    13fc:	01c6d713          	srli	a4,a3,0x1c
    1400:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1402:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1406:	00000717          	auipc	a4,0x0
    140a:	24a73d23          	sd	a0,602(a4) # 1660 <freep>
      return (void*)(p + 1);
    140e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1412:	70e2                	ld	ra,56(sp)
    1414:	7442                	ld	s0,48(sp)
    1416:	74a2                	ld	s1,40(sp)
    1418:	7902                	ld	s2,32(sp)
    141a:	69e2                	ld	s3,24(sp)
    141c:	6a42                	ld	s4,16(sp)
    141e:	6aa2                	ld	s5,8(sp)
    1420:	6b02                	ld	s6,0(sp)
    1422:	6121                	addi	sp,sp,64
    1424:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1426:	6398                	ld	a4,0(a5)
    1428:	e118                	sd	a4,0(a0)
    142a:	bff1                	j	1406 <malloc+0x88>
  hp->s.size = nu;
    142c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1430:	0541                	addi	a0,a0,16
    1432:	00000097          	auipc	ra,0x0
    1436:	eca080e7          	jalr	-310(ra) # 12fc <free>
  return freep;
    143a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    143e:	d971                	beqz	a0,1412 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1440:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1442:	4798                	lw	a4,8(a5)
    1444:	fa9775e3          	bgeu	a4,s1,13ee <malloc+0x70>
    if(p == freep)
    1448:	00093703          	ld	a4,0(s2)
    144c:	853e                	mv	a0,a5
    144e:	fef719e3          	bne	a4,a5,1440 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    1452:	8552                	mv	a0,s4
    1454:	00000097          	auipc	ra,0x0
    1458:	b80080e7          	jalr	-1152(ra) # fd4 <sbrk>
  if(p == (char*)-1)
    145c:	fd5518e3          	bne	a0,s5,142c <malloc+0xae>
        return 0;
    1460:	4501                	li	a0,0
    1462:	bf45                	j	1412 <malloc+0x94>
