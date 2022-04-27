
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	4d0080e7          	jalr	1232(ra) # 4e0 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return name as string.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	4a4080e7          	jalr	1188(ra) # 4e0 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	482080e7          	jalr	1154(ra) # 4e0 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	d7298993          	addi	s3,s3,-654 # dd8 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	66e080e7          	jalr	1646(ra) # 6e4 <memmove>
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	460080e7          	jalr	1120(ra) # 4e0 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	452080e7          	jalr	1106(ra) # 4e0 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	4581                	li	a1,0
  a2:	01298533          	add	a0,s3,s2
  a6:	00000097          	auipc	ra,0x0
  aa:	4f6080e7          	jalr	1270(ra) # 59c <memset>
  return buf;
  ae:	84ce                	mv	s1,s3
  b0:	bf71                	j	4c <fmtname+0x4c>

00000000000000b2 <search>:

void search(char *path, char *buf, int fd, struct stat st, char *fname)
{
  b2:	7155                	addi	sp,sp,-208
  b4:	e586                	sd	ra,200(sp)
  b6:	e1a2                	sd	s0,192(sp)
  b8:	fd26                	sd	s1,184(sp)
  ba:	f94a                	sd	s2,176(sp)
  bc:	f54e                	sd	s3,168(sp)
  be:	f152                	sd	s4,160(sp)
  c0:	ed56                	sd	s5,152(sp)
  c2:	e95a                	sd	s6,144(sp)
  c4:	e55e                	sd	s7,136(sp)
  c6:	e162                	sd	s8,128(sp)
  c8:	fce6                	sd	s9,120(sp)
  ca:	f8ea                	sd	s10,112(sp)
  cc:	f4ee                	sd	s11,104(sp)
  ce:	0980                	addi	s0,sp,208
  d0:	8baa                	mv	s7,a0
  d2:	84ae                	mv	s1,a1
  d4:	8932                	mv	s2,a2
  d6:	89b6                	mv	s3,a3
  d8:	8aba                	mv	s5,a4
  char *p;
  struct dirent de;
  struct stat st2;

  if(strlen(path) + 1 + DIRSIZ + 1 > 512){
  da:	00000097          	auipc	ra,0x0
  de:	406080e7          	jalr	1030(ra) # 4e0 <strlen>
  e2:	2541                	addiw	a0,a0,16
  e4:	20000793          	li	a5,512
  e8:	04a7e663          	bltu	a5,a0,134 <search+0x82>
    printf("find: path too long\n");
  }
  strcpy(buf, path);
  ec:	85de                	mv	a1,s7
  ee:	8526                	mv	a0,s1
  f0:	00000097          	auipc	ra,0x0
  f4:	3a8080e7          	jalr	936(ra) # 498 <strcpy>
  p = buf+strlen(buf);
  f8:	8526                	mv	a0,s1
  fa:	00000097          	auipc	ra,0x0
  fe:	3e6080e7          	jalr	998(ra) # 4e0 <strlen>
 102:	02051a13          	slli	s4,a0,0x20
 106:	020a5a13          	srli	s4,s4,0x20
 10a:	9a26                	add	s4,s4,s1
  *p++ = '/';
 10c:	001a0b13          	addi	s6,s4,1
 110:	02f00793          	li	a5,47
 114:	00fa0023          	sb	a5,0(s4)
    if (strsub(fmtname(buf), fname) >= 0) {
      printf("%d    %s\n", st.type, buf);
    }

    // if folder: call search recursively
    if (st.type == T_DIR) {
 118:	4c05                	li	s8,1
      // ignore . and .. folders
      if (strcmp(fmtname(buf), ".") != 0 && strcmp(fmtname(buf), "..") != 0) {
 11a:	00001d17          	auipc	s10,0x1
 11e:	bd6d0d13          	addi	s10,s10,-1066 # cf0 <malloc+0x128>
 122:	00001d97          	auipc	s11,0x1
 126:	bd6d8d93          	addi	s11,s11,-1066 # cf8 <malloc+0x130>
      printf("%d    %s\n", st.type, buf);
 12a:	00001c97          	auipc	s9,0x1
 12e:	bb6c8c93          	addi	s9,s9,-1098 # ce0 <malloc+0x118>
  while(read(fd, &de, sizeof(de)) == sizeof(de)){
 132:	a805                	j	162 <search+0xb0>
    printf("find: path too long\n");
 134:	00001517          	auipc	a0,0x1
 138:	b7c50513          	addi	a0,a0,-1156 # cb0 <malloc+0xe8>
 13c:	00001097          	auipc	ra,0x1
 140:	9d4080e7          	jalr	-1580(ra) # b10 <printf>
 144:	b765                	j	ec <search+0x3a>
      printf("find: cannot stat %s\n", buf);
 146:	85a6                	mv	a1,s1
 148:	00001517          	auipc	a0,0x1
 14c:	b8050513          	addi	a0,a0,-1152 # cc8 <malloc+0x100>
 150:	00001097          	auipc	ra,0x1
 154:	9c0080e7          	jalr	-1600(ra) # b10 <printf>
      continue;
 158:	a029                	j	162 <search+0xb0>
    if (st.type == T_DIR) {
 15a:	00899783          	lh	a5,8(s3)
 15e:	07878763          	beq	a5,s8,1cc <search+0x11a>
  while(read(fd, &de, sizeof(de)) == sizeof(de)){
 162:	4641                	li	a2,16
 164:	f8040593          	addi	a1,s0,-128
 168:	854a                	mv	a0,s2
 16a:	00000097          	auipc	ra,0x0
 16e:	644080e7          	jalr	1604(ra) # 7ae <read>
 172:	47c1                	li	a5,16
 174:	10f51063          	bne	a0,a5,274 <search+0x1c2>
    if(de.inum == 0)
 178:	f8045783          	lhu	a5,-128(s0)
 17c:	d3fd                	beqz	a5,162 <search+0xb0>
    memmove(p, de.name, DIRSIZ);
 17e:	4639                	li	a2,14
 180:	f8240593          	addi	a1,s0,-126
 184:	855a                	mv	a0,s6
 186:	00000097          	auipc	ra,0x0
 18a:	55e080e7          	jalr	1374(ra) # 6e4 <memmove>
    p[DIRSIZ] = 0;
 18e:	000a07a3          	sb	zero,15(s4)
    if(stat(buf, &st) < 0){
 192:	85ce                	mv	a1,s3
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	4c0080e7          	jalr	1216(ra) # 656 <stat>
 19e:	fa0544e3          	bltz	a0,146 <search+0x94>
    if (strsub(fmtname(buf), fname) >= 0) {
 1a2:	8526                	mv	a0,s1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	e5c080e7          	jalr	-420(ra) # 0 <fmtname>
 1ac:	85d6                	mv	a1,s5
 1ae:	00000097          	auipc	ra,0x0
 1b2:	35c080e7          	jalr	860(ra) # 50a <strsub>
 1b6:	fa0542e3          	bltz	a0,15a <search+0xa8>
      printf("%d    %s\n", st.type, buf);
 1ba:	8626                	mv	a2,s1
 1bc:	00899583          	lh	a1,8(s3)
 1c0:	8566                	mv	a0,s9
 1c2:	00001097          	auipc	ra,0x1
 1c6:	94e080e7          	jalr	-1714(ra) # b10 <printf>
 1ca:	bf41                	j	15a <search+0xa8>
      if (strcmp(fmtname(buf), ".") != 0 && strcmp(fmtname(buf), "..") != 0) {
 1cc:	8526                	mv	a0,s1
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e32080e7          	jalr	-462(ra) # 0 <fmtname>
 1d6:	85ea                	mv	a1,s10
 1d8:	00000097          	auipc	ra,0x0
 1dc:	2dc080e7          	jalr	732(ra) # 4b4 <strcmp>
 1e0:	d149                	beqz	a0,162 <search+0xb0>
 1e2:	8526                	mv	a0,s1
 1e4:	00000097          	auipc	ra,0x0
 1e8:	e1c080e7          	jalr	-484(ra) # 0 <fmtname>
 1ec:	85ee                	mv	a1,s11
 1ee:	00000097          	auipc	ra,0x0
 1f2:	2c6080e7          	jalr	710(ra) # 4b4 <strcmp>
 1f6:	d535                	beqz	a0,162 <search+0xb0>
        int fd2 = open(buf, 0);
 1f8:	4581                	li	a1,0
 1fa:	8526                	mv	a0,s1
 1fc:	00000097          	auipc	ra,0x0
 200:	5da080e7          	jalr	1498(ra) # 7d6 <open>
 204:	f2a43c23          	sd	a0,-200(s0)
        if(fstat(fd, &st2) < 0){
 208:	f6840593          	addi	a1,s0,-152
 20c:	854a                	mv	a0,s2
 20e:	00000097          	auipc	ra,0x0
 212:	5e0080e7          	jalr	1504(ra) # 7ee <fstat>
 216:	04054063          	bltz	a0,256 <search+0x1a4>
          fprintf(2, "find: cannot stat %s\n", path);
          close(fd);
          return;
        }
        
        search(buf, buf, fd2, st2, fname);
 21a:	f6843783          	ld	a5,-152(s0)
 21e:	f4f43023          	sd	a5,-192(s0)
 222:	f7043783          	ld	a5,-144(s0)
 226:	f4f43423          	sd	a5,-184(s0)
 22a:	f7843783          	ld	a5,-136(s0)
 22e:	f4f43823          	sd	a5,-176(s0)
 232:	8756                	mv	a4,s5
 234:	f4040693          	addi	a3,s0,-192
 238:	f3843603          	ld	a2,-200(s0)
 23c:	85a6                	mv	a1,s1
 23e:	8526                	mv	a0,s1
 240:	00000097          	auipc	ra,0x0
 244:	e72080e7          	jalr	-398(ra) # b2 <search>
        close(fd2);
 248:	f3843503          	ld	a0,-200(s0)
 24c:	00000097          	auipc	ra,0x0
 250:	572080e7          	jalr	1394(ra) # 7be <close>
 254:	b739                	j	162 <search+0xb0>
          fprintf(2, "find: cannot stat %s\n", path);
 256:	865e                	mv	a2,s7
 258:	00001597          	auipc	a1,0x1
 25c:	a7058593          	addi	a1,a1,-1424 # cc8 <malloc+0x100>
 260:	4509                	li	a0,2
 262:	00001097          	auipc	ra,0x1
 266:	880080e7          	jalr	-1920(ra) # ae2 <fprintf>
          close(fd);
 26a:	854a                	mv	a0,s2
 26c:	00000097          	auipc	ra,0x0
 270:	552080e7          	jalr	1362(ra) # 7be <close>
      }
    }
  }
}
 274:	60ae                	ld	ra,200(sp)
 276:	640e                	ld	s0,192(sp)
 278:	74ea                	ld	s1,184(sp)
 27a:	794a                	ld	s2,176(sp)
 27c:	79aa                	ld	s3,168(sp)
 27e:	7a0a                	ld	s4,160(sp)
 280:	6aea                	ld	s5,152(sp)
 282:	6b4a                	ld	s6,144(sp)
 284:	6baa                	ld	s7,136(sp)
 286:	6c0a                	ld	s8,128(sp)
 288:	7ce6                	ld	s9,120(sp)
 28a:	7d46                	ld	s10,112(sp)
 28c:	7da6                	ld	s11,104(sp)
 28e:	6169                	addi	sp,sp,208
 290:	8082                	ret

0000000000000292 <find>:

void find(char *path, char *fname){
 292:	d7010113          	addi	sp,sp,-656
 296:	28113423          	sd	ra,648(sp)
 29a:	28813023          	sd	s0,640(sp)
 29e:	26913c23          	sd	s1,632(sp)
 2a2:	27213823          	sd	s2,624(sp)
 2a6:	27313423          	sd	s3,616(sp)
 2aa:	27413023          	sd	s4,608(sp)
 2ae:	25513c23          	sd	s5,600(sp)
 2b2:	25613823          	sd	s6,592(sp)
 2b6:	0d00                	addi	s0,sp,656
 2b8:	89aa                	mv	s3,a0
 2ba:	892e                	mv	s2,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
 2bc:	4581                	li	a1,0
 2be:	00000097          	auipc	ra,0x0
 2c2:	518080e7          	jalr	1304(ra) # 7d6 <open>
 2c6:	04054863          	bltz	a0,316 <find+0x84>
 2ca:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
 2cc:	d9840593          	addi	a1,s0,-616
 2d0:	00000097          	auipc	ra,0x0
 2d4:	51e080e7          	jalr	1310(ra) # 7ee <fstat>
 2d8:	04054a63          	bltz	a0,32c <find+0x9a>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
 2dc:	da041703          	lh	a4,-608(s0)
 2e0:	4785                	li	a5,1
 2e2:	06f70563          	beq	a4,a5,34c <find+0xba>
          //
          search(path, buf, fd, st, fname);
        }
        break;
    }
    close(fd);
 2e6:	8526                	mv	a0,s1
 2e8:	00000097          	auipc	ra,0x0
 2ec:	4d6080e7          	jalr	1238(ra) # 7be <close>
}
 2f0:	28813083          	ld	ra,648(sp)
 2f4:	28013403          	ld	s0,640(sp)
 2f8:	27813483          	ld	s1,632(sp)
 2fc:	27013903          	ld	s2,624(sp)
 300:	26813983          	ld	s3,616(sp)
 304:	26013a03          	ld	s4,608(sp)
 308:	25813a83          	ld	s5,600(sp)
 30c:	25013b03          	ld	s6,592(sp)
 310:	29010113          	addi	sp,sp,656
 314:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
 316:	864e                	mv	a2,s3
 318:	00001597          	auipc	a1,0x1
 31c:	9e858593          	addi	a1,a1,-1560 # d00 <malloc+0x138>
 320:	4509                	li	a0,2
 322:	00000097          	auipc	ra,0x0
 326:	7c0080e7          	jalr	1984(ra) # ae2 <fprintf>
        return;
 32a:	b7d9                	j	2f0 <find+0x5e>
        fprintf(2, "find: cannot stat %s\n", path);
 32c:	864e                	mv	a2,s3
 32e:	00001597          	auipc	a1,0x1
 332:	99a58593          	addi	a1,a1,-1638 # cc8 <malloc+0x100>
 336:	4509                	li	a0,2
 338:	00000097          	auipc	ra,0x0
 33c:	7aa080e7          	jalr	1962(ra) # ae2 <fprintf>
        close(fd);
 340:	8526                	mv	a0,s1
 342:	00000097          	auipc	ra,0x0
 346:	47c080e7          	jalr	1148(ra) # 7be <close>
        return;
 34a:	b75d                	j	2f0 <find+0x5e>
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
 34c:	854e                	mv	a0,s3
 34e:	00000097          	auipc	ra,0x0
 352:	192080e7          	jalr	402(ra) # 4e0 <strlen>
 356:	2541                	addiw	a0,a0,16
 358:	20000793          	li	a5,512
 35c:	00a7fb63          	bgeu	a5,a0,372 <find+0xe0>
        printf("find: path too long\n");
 360:	00001517          	auipc	a0,0x1
 364:	95050513          	addi	a0,a0,-1712 # cb0 <malloc+0xe8>
 368:	00000097          	auipc	ra,0x0
 36c:	7a8080e7          	jalr	1960(ra) # b10 <printf>
        break;
 370:	bf9d                	j	2e6 <find+0x54>
        strcpy(buf, path);
 372:	85ce                	mv	a1,s3
 374:	dc040513          	addi	a0,s0,-576
 378:	00000097          	auipc	ra,0x0
 37c:	120080e7          	jalr	288(ra) # 498 <strcpy>
        p = buf+strlen(buf);
 380:	dc040513          	addi	a0,s0,-576
 384:	00000097          	auipc	ra,0x0
 388:	15c080e7          	jalr	348(ra) # 4e0 <strlen>
 38c:	1502                	slli	a0,a0,0x20
 38e:	9101                	srli	a0,a0,0x20
 390:	dc040793          	addi	a5,s0,-576
 394:	00a78a33          	add	s4,a5,a0
        *p++ = '/';
 398:	001a0a93          	addi	s5,s4,1
 39c:	02f00793          	li	a5,47
 3a0:	00fa0023          	sb	a5,0(s4)
              printf("ls: cannot stat %s\n", buf);
 3a4:	00001b17          	auipc	s6,0x1
 3a8:	974b0b13          	addi	s6,s6,-1676 # d18 <malloc+0x150>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
 3ac:	a801                	j	3bc <find+0x12a>
              printf("ls: cannot stat %s\n", buf);
 3ae:	dc040593          	addi	a1,s0,-576
 3b2:	855a                	mv	a0,s6
 3b4:	00000097          	auipc	ra,0x0
 3b8:	75c080e7          	jalr	1884(ra) # b10 <printf>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
 3bc:	4641                	li	a2,16
 3be:	db040593          	addi	a1,s0,-592
 3c2:	8526                	mv	a0,s1
 3c4:	00000097          	auipc	ra,0x0
 3c8:	3ea080e7          	jalr	1002(ra) # 7ae <read>
 3cc:	47c1                	li	a5,16
 3ce:	f0f51ce3          	bne	a0,a5,2e6 <find+0x54>
          if(de.inum == 0)
 3d2:	db045783          	lhu	a5,-592(s0)
 3d6:	d3fd                	beqz	a5,3bc <find+0x12a>
          memmove(p, de.name, DIRSIZ);
 3d8:	4639                	li	a2,14
 3da:	db240593          	addi	a1,s0,-590
 3de:	8556                	mv	a0,s5
 3e0:	00000097          	auipc	ra,0x0
 3e4:	304080e7          	jalr	772(ra) # 6e4 <memmove>
          p[DIRSIZ] = 0;
 3e8:	000a07a3          	sb	zero,15(s4)
          if(stat(buf, &st) < 0){
 3ec:	d9840593          	addi	a1,s0,-616
 3f0:	dc040513          	addi	a0,s0,-576
 3f4:	00000097          	auipc	ra,0x0
 3f8:	262080e7          	jalr	610(ra) # 656 <stat>
 3fc:	fa0549e3          	bltz	a0,3ae <find+0x11c>
          search(path, buf, fd, st, fname);
 400:	d9843783          	ld	a5,-616(s0)
 404:	d6f43823          	sd	a5,-656(s0)
 408:	da043783          	ld	a5,-608(s0)
 40c:	d6f43c23          	sd	a5,-648(s0)
 410:	da843783          	ld	a5,-600(s0)
 414:	d8f43023          	sd	a5,-640(s0)
 418:	874a                	mv	a4,s2
 41a:	d7040693          	addi	a3,s0,-656
 41e:	8626                	mv	a2,s1
 420:	dc040593          	addi	a1,s0,-576
 424:	854e                	mv	a0,s3
 426:	00000097          	auipc	ra,0x0
 42a:	c8c080e7          	jalr	-884(ra) # b2 <search>
 42e:	b779                	j	3bc <find+0x12a>

0000000000000430 <main>:

int main(int argc, char *argv[]){
 430:	7179                	addi	sp,sp,-48
 432:	f406                	sd	ra,40(sp)
 434:	f022                	sd	s0,32(sp)
 436:	ec26                	sd	s1,24(sp)
 438:	e84a                	sd	s2,16(sp)
 43a:	e44e                	sd	s3,8(sp)
 43c:	1800                	addi	s0,sp,48
    if(argc < 2){
 43e:	4785                	li	a5,1
 440:	02a7de63          	bge	a5,a0,47c <main+0x4c>
 444:	00858493          	addi	s1,a1,8
 448:	ffe5091b          	addiw	s2,a0,-2
 44c:	02091793          	slli	a5,s2,0x20
 450:	01d7d913          	srli	s2,a5,0x1d
 454:	05c1                	addi	a1,a1,16
 456:	992e                	add	s2,s2,a1
        exit(0);
    }

    int i;
    for(i = 1; i < argc; i++){
        find(".", argv[i]);
 458:	00001997          	auipc	s3,0x1
 45c:	89898993          	addi	s3,s3,-1896 # cf0 <malloc+0x128>
 460:	608c                	ld	a1,0(s1)
 462:	854e                	mv	a0,s3
 464:	00000097          	auipc	ra,0x0
 468:	e2e080e7          	jalr	-466(ra) # 292 <find>
    for(i = 1; i < argc; i++){
 46c:	04a1                	addi	s1,s1,8
 46e:	ff2499e3          	bne	s1,s2,460 <main+0x30>
    }

    exit(0);
 472:	4501                	li	a0,0
 474:	00000097          	auipc	ra,0x0
 478:	322080e7          	jalr	802(ra) # 796 <exit>
        fprintf(2, "at leat one argument is required\n");
 47c:	00001597          	auipc	a1,0x1
 480:	8b458593          	addi	a1,a1,-1868 # d30 <malloc+0x168>
 484:	4509                	li	a0,2
 486:	00000097          	auipc	ra,0x0
 48a:	65c080e7          	jalr	1628(ra) # ae2 <fprintf>
        exit(0);
 48e:	4501                	li	a0,0
 490:	00000097          	auipc	ra,0x0
 494:	306080e7          	jalr	774(ra) # 796 <exit>

0000000000000498 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 49e:	87aa                	mv	a5,a0
 4a0:	0585                	addi	a1,a1,1
 4a2:	0785                	addi	a5,a5,1
 4a4:	fff5c703          	lbu	a4,-1(a1)
 4a8:	fee78fa3          	sb	a4,-1(a5)
 4ac:	fb75                	bnez	a4,4a0 <strcpy+0x8>
    ;
  return os;
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret

00000000000004b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e422                	sd	s0,8(sp)
 4b8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 4ba:	00054783          	lbu	a5,0(a0)
 4be:	cb91                	beqz	a5,4d2 <strcmp+0x1e>
 4c0:	0005c703          	lbu	a4,0(a1)
 4c4:	00f71763          	bne	a4,a5,4d2 <strcmp+0x1e>
    p++, q++;
 4c8:	0505                	addi	a0,a0,1
 4ca:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4cc:	00054783          	lbu	a5,0(a0)
 4d0:	fbe5                	bnez	a5,4c0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4d2:	0005c503          	lbu	a0,0(a1)
}
 4d6:	40a7853b          	subw	a0,a5,a0
 4da:	6422                	ld	s0,8(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e422                	sd	s0,8(sp)
 4e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4e6:	00054783          	lbu	a5,0(a0)
 4ea:	cf91                	beqz	a5,506 <strlen+0x26>
 4ec:	0505                	addi	a0,a0,1
 4ee:	87aa                	mv	a5,a0
 4f0:	4685                	li	a3,1
 4f2:	9e89                	subw	a3,a3,a0
 4f4:	00f6853b          	addw	a0,a3,a5
 4f8:	0785                	addi	a5,a5,1
 4fa:	fff7c703          	lbu	a4,-1(a5)
 4fe:	fb7d                	bnez	a4,4f4 <strlen+0x14>
    ;
  return n;
}
 500:	6422                	ld	s0,8(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret
  for(n = 0; s[n]; n++)
 506:	4501                	li	a0,0
 508:	bfe5                	j	500 <strlen+0x20>

000000000000050a <strsub>:
int strsub(const char *s, const char *sub){
 50a:	7139                	addi	sp,sp,-64
 50c:	fc06                	sd	ra,56(sp)
 50e:	f822                	sd	s0,48(sp)
 510:	f426                	sd	s1,40(sp)
 512:	f04a                	sd	s2,32(sp)
 514:	ec4e                	sd	s3,24(sp)
 516:	e852                	sd	s4,16(sp)
 518:	e456                	sd	s5,8(sp)
 51a:	0080                	addi	s0,sp,64
 51c:	8a2a                	mv	s4,a0
 51e:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 520:	84aa                	mv	s1,a0
 522:	4901                	li	s2,0
 524:	a019                	j	52a <strsub+0x20>
 526:	2905                	addiw	s2,s2,1
 528:	0485                	addi	s1,s1,1
 52a:	8552                	mv	a0,s4
 52c:	00000097          	auipc	ra,0x0
 530:	fb4080e7          	jalr	-76(ra) # 4e0 <strlen>
 534:	2501                	sext.w	a0,a0
 536:	04a97863          	bgeu	s2,a0,586 <strsub+0x7c>
    if(s[i] == sub[0]){
 53a:	8aa6                	mv	s5,s1
 53c:	0004c703          	lbu	a4,0(s1)
 540:	0009c783          	lbu	a5,0(s3)
 544:	fef711e3          	bne	a4,a5,526 <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 548:	854e                	mv	a0,s3
 54a:	00000097          	auipc	ra,0x0
 54e:	f96080e7          	jalr	-106(ra) # 4e0 <strlen>
 552:	0005059b          	sext.w	a1,a0
 556:	ffe5061b          	addiw	a2,a0,-2
 55a:	1602                	slli	a2,a2,0x20
 55c:	9201                	srli	a2,a2,0x20
 55e:	0609                	addi	a2,a2,2
 560:	4785                	li	a5,1
 562:	0007871b          	sext.w	a4,a5
 566:	fcb770e3          	bgeu	a4,a1,526 <strsub+0x1c>
        if(s[j+i] != sub[j]){
 56a:	00fa86b3          	add	a3,s5,a5
 56e:	00f98733          	add	a4,s3,a5
 572:	0006c683          	lbu	a3,0(a3)
 576:	00074703          	lbu	a4,0(a4)
 57a:	fae696e3          	bne	a3,a4,526 <strsub+0x1c>
        if(j == strlen(sub) -1){
 57e:	0785                	addi	a5,a5,1
 580:	fec791e3          	bne	a5,a2,562 <strsub+0x58>
 584:	a011                	j	588 <strsub+0x7e>
  return -1;
 586:	597d                	li	s2,-1
}
 588:	854a                	mv	a0,s2
 58a:	70e2                	ld	ra,56(sp)
 58c:	7442                	ld	s0,48(sp)
 58e:	74a2                	ld	s1,40(sp)
 590:	7902                	ld	s2,32(sp)
 592:	69e2                	ld	s3,24(sp)
 594:	6a42                	ld	s4,16(sp)
 596:	6aa2                	ld	s5,8(sp)
 598:	6121                	addi	sp,sp,64
 59a:	8082                	ret

000000000000059c <memset>:

void*
memset(void *dst, int c, uint n)
{
 59c:	1141                	addi	sp,sp,-16
 59e:	e422                	sd	s0,8(sp)
 5a0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 5a2:	ca19                	beqz	a2,5b8 <memset+0x1c>
 5a4:	87aa                	mv	a5,a0
 5a6:	1602                	slli	a2,a2,0x20
 5a8:	9201                	srli	a2,a2,0x20
 5aa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 5ae:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 5b2:	0785                	addi	a5,a5,1
 5b4:	fee79de3          	bne	a5,a4,5ae <memset+0x12>
  }
  return dst;
}
 5b8:	6422                	ld	s0,8(sp)
 5ba:	0141                	addi	sp,sp,16
 5bc:	8082                	ret

00000000000005be <strchr>:

char*
strchr(const char *s, char c)
{
 5be:	1141                	addi	sp,sp,-16
 5c0:	e422                	sd	s0,8(sp)
 5c2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5c4:	00054783          	lbu	a5,0(a0)
 5c8:	cb99                	beqz	a5,5de <strchr+0x20>
    if(*s == c)
 5ca:	00f58763          	beq	a1,a5,5d8 <strchr+0x1a>
  for(; *s; s++)
 5ce:	0505                	addi	a0,a0,1
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	fbfd                	bnez	a5,5ca <strchr+0xc>
      return (char*)s;
  return 0;
 5d6:	4501                	li	a0,0
}
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret
  return 0;
 5de:	4501                	li	a0,0
 5e0:	bfe5                	j	5d8 <strchr+0x1a>

00000000000005e2 <gets>:

char*
gets(char *buf, int max)
{
 5e2:	711d                	addi	sp,sp,-96
 5e4:	ec86                	sd	ra,88(sp)
 5e6:	e8a2                	sd	s0,80(sp)
 5e8:	e4a6                	sd	s1,72(sp)
 5ea:	e0ca                	sd	s2,64(sp)
 5ec:	fc4e                	sd	s3,56(sp)
 5ee:	f852                	sd	s4,48(sp)
 5f0:	f456                	sd	s5,40(sp)
 5f2:	f05a                	sd	s6,32(sp)
 5f4:	ec5e                	sd	s7,24(sp)
 5f6:	1080                	addi	s0,sp,96
 5f8:	8baa                	mv	s7,a0
 5fa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5fc:	892a                	mv	s2,a0
 5fe:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 600:	4aa9                	li	s5,10
 602:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 604:	89a6                	mv	s3,s1
 606:	2485                	addiw	s1,s1,1
 608:	0344d863          	bge	s1,s4,638 <gets+0x56>
    cc = read(0, &c, 1);
 60c:	4605                	li	a2,1
 60e:	faf40593          	addi	a1,s0,-81
 612:	4501                	li	a0,0
 614:	00000097          	auipc	ra,0x0
 618:	19a080e7          	jalr	410(ra) # 7ae <read>
    if(cc < 1)
 61c:	00a05e63          	blez	a0,638 <gets+0x56>
    buf[i++] = c;
 620:	faf44783          	lbu	a5,-81(s0)
 624:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 628:	01578763          	beq	a5,s5,636 <gets+0x54>
 62c:	0905                	addi	s2,s2,1
 62e:	fd679be3          	bne	a5,s6,604 <gets+0x22>
  for(i=0; i+1 < max; ){
 632:	89a6                	mv	s3,s1
 634:	a011                	j	638 <gets+0x56>
 636:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 638:	99de                	add	s3,s3,s7
 63a:	00098023          	sb	zero,0(s3)
  return buf;
}
 63e:	855e                	mv	a0,s7
 640:	60e6                	ld	ra,88(sp)
 642:	6446                	ld	s0,80(sp)
 644:	64a6                	ld	s1,72(sp)
 646:	6906                	ld	s2,64(sp)
 648:	79e2                	ld	s3,56(sp)
 64a:	7a42                	ld	s4,48(sp)
 64c:	7aa2                	ld	s5,40(sp)
 64e:	7b02                	ld	s6,32(sp)
 650:	6be2                	ld	s7,24(sp)
 652:	6125                	addi	sp,sp,96
 654:	8082                	ret

0000000000000656 <stat>:

int
stat(const char *n, struct stat *st)
{
 656:	1101                	addi	sp,sp,-32
 658:	ec06                	sd	ra,24(sp)
 65a:	e822                	sd	s0,16(sp)
 65c:	e426                	sd	s1,8(sp)
 65e:	e04a                	sd	s2,0(sp)
 660:	1000                	addi	s0,sp,32
 662:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 664:	4581                	li	a1,0
 666:	00000097          	auipc	ra,0x0
 66a:	170080e7          	jalr	368(ra) # 7d6 <open>
  if(fd < 0)
 66e:	02054563          	bltz	a0,698 <stat+0x42>
 672:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 674:	85ca                	mv	a1,s2
 676:	00000097          	auipc	ra,0x0
 67a:	178080e7          	jalr	376(ra) # 7ee <fstat>
 67e:	892a                	mv	s2,a0
  close(fd);
 680:	8526                	mv	a0,s1
 682:	00000097          	auipc	ra,0x0
 686:	13c080e7          	jalr	316(ra) # 7be <close>
  return r;
}
 68a:	854a                	mv	a0,s2
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	64a2                	ld	s1,8(sp)
 692:	6902                	ld	s2,0(sp)
 694:	6105                	addi	sp,sp,32
 696:	8082                	ret
    return -1;
 698:	597d                	li	s2,-1
 69a:	bfc5                	j	68a <stat+0x34>

000000000000069c <atoi>:

int
atoi(const char *s)
{
 69c:	1141                	addi	sp,sp,-16
 69e:	e422                	sd	s0,8(sp)
 6a0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a2:	00054683          	lbu	a3,0(a0)
 6a6:	fd06879b          	addiw	a5,a3,-48
 6aa:	0ff7f793          	zext.b	a5,a5
 6ae:	4625                	li	a2,9
 6b0:	02f66863          	bltu	a2,a5,6e0 <atoi+0x44>
 6b4:	872a                	mv	a4,a0
  n = 0;
 6b6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 6b8:	0705                	addi	a4,a4,1
 6ba:	0025179b          	slliw	a5,a0,0x2
 6be:	9fa9                	addw	a5,a5,a0
 6c0:	0017979b          	slliw	a5,a5,0x1
 6c4:	9fb5                	addw	a5,a5,a3
 6c6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6ca:	00074683          	lbu	a3,0(a4)
 6ce:	fd06879b          	addiw	a5,a3,-48
 6d2:	0ff7f793          	zext.b	a5,a5
 6d6:	fef671e3          	bgeu	a2,a5,6b8 <atoi+0x1c>
  return n;
}
 6da:	6422                	ld	s0,8(sp)
 6dc:	0141                	addi	sp,sp,16
 6de:	8082                	ret
  n = 0;
 6e0:	4501                	li	a0,0
 6e2:	bfe5                	j	6da <atoi+0x3e>

00000000000006e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6e4:	1141                	addi	sp,sp,-16
 6e6:	e422                	sd	s0,8(sp)
 6e8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6ea:	02b57463          	bgeu	a0,a1,712 <memmove+0x2e>
    while(n-- > 0)
 6ee:	00c05f63          	blez	a2,70c <memmove+0x28>
 6f2:	1602                	slli	a2,a2,0x20
 6f4:	9201                	srli	a2,a2,0x20
 6f6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6fa:	872a                	mv	a4,a0
      *dst++ = *src++;
 6fc:	0585                	addi	a1,a1,1
 6fe:	0705                	addi	a4,a4,1
 700:	fff5c683          	lbu	a3,-1(a1)
 704:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 708:	fee79ae3          	bne	a5,a4,6fc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 70c:	6422                	ld	s0,8(sp)
 70e:	0141                	addi	sp,sp,16
 710:	8082                	ret
    dst += n;
 712:	00c50733          	add	a4,a0,a2
    src += n;
 716:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 718:	fec05ae3          	blez	a2,70c <memmove+0x28>
 71c:	fff6079b          	addiw	a5,a2,-1
 720:	1782                	slli	a5,a5,0x20
 722:	9381                	srli	a5,a5,0x20
 724:	fff7c793          	not	a5,a5
 728:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 72a:	15fd                	addi	a1,a1,-1
 72c:	177d                	addi	a4,a4,-1
 72e:	0005c683          	lbu	a3,0(a1)
 732:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 736:	fee79ae3          	bne	a5,a4,72a <memmove+0x46>
 73a:	bfc9                	j	70c <memmove+0x28>

000000000000073c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 73c:	1141                	addi	sp,sp,-16
 73e:	e422                	sd	s0,8(sp)
 740:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 742:	ca05                	beqz	a2,772 <memcmp+0x36>
 744:	fff6069b          	addiw	a3,a2,-1
 748:	1682                	slli	a3,a3,0x20
 74a:	9281                	srli	a3,a3,0x20
 74c:	0685                	addi	a3,a3,1
 74e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 750:	00054783          	lbu	a5,0(a0)
 754:	0005c703          	lbu	a4,0(a1)
 758:	00e79863          	bne	a5,a4,768 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 75c:	0505                	addi	a0,a0,1
    p2++;
 75e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 760:	fed518e3          	bne	a0,a3,750 <memcmp+0x14>
  }
  return 0;
 764:	4501                	li	a0,0
 766:	a019                	j	76c <memcmp+0x30>
      return *p1 - *p2;
 768:	40e7853b          	subw	a0,a5,a4
}
 76c:	6422                	ld	s0,8(sp)
 76e:	0141                	addi	sp,sp,16
 770:	8082                	ret
  return 0;
 772:	4501                	li	a0,0
 774:	bfe5                	j	76c <memcmp+0x30>

0000000000000776 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 776:	1141                	addi	sp,sp,-16
 778:	e406                	sd	ra,8(sp)
 77a:	e022                	sd	s0,0(sp)
 77c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 77e:	00000097          	auipc	ra,0x0
 782:	f66080e7          	jalr	-154(ra) # 6e4 <memmove>
}
 786:	60a2                	ld	ra,8(sp)
 788:	6402                	ld	s0,0(sp)
 78a:	0141                	addi	sp,sp,16
 78c:	8082                	ret

000000000000078e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 78e:	4885                	li	a7,1
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <exit>:
.global exit
exit:
 li a7, SYS_exit
 796:	4889                	li	a7,2
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <wait>:
.global wait
wait:
 li a7, SYS_wait
 79e:	488d                	li	a7,3
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7a6:	4891                	li	a7,4
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <read>:
.global read
read:
 li a7, SYS_read
 7ae:	4895                	li	a7,5
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <write>:
.global write
write:
 li a7, SYS_write
 7b6:	48c1                	li	a7,16
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <close>:
.global close
close:
 li a7, SYS_close
 7be:	48d5                	li	a7,21
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7c6:	4899                	li	a7,6
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <exec>:
.global exec
exec:
 li a7, SYS_exec
 7ce:	489d                	li	a7,7
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <open>:
.global open
open:
 li a7, SYS_open
 7d6:	48bd                	li	a7,15
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7de:	48c5                	li	a7,17
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7e6:	48c9                	li	a7,18
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7ee:	48a1                	li	a7,8
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <link>:
.global link
link:
 li a7, SYS_link
 7f6:	48cd                	li	a7,19
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7fe:	48d1                	li	a7,20
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 806:	48a5                	li	a7,9
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <dup>:
.global dup
dup:
 li a7, SYS_dup
 80e:	48a9                	li	a7,10
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 816:	48ad                	li	a7,11
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 81e:	48b1                	li	a7,12
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 826:	48b5                	li	a7,13
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 82e:	48b9                	li	a7,14
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 836:	1101                	addi	sp,sp,-32
 838:	ec06                	sd	ra,24(sp)
 83a:	e822                	sd	s0,16(sp)
 83c:	1000                	addi	s0,sp,32
 83e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 842:	4605                	li	a2,1
 844:	fef40593          	addi	a1,s0,-17
 848:	00000097          	auipc	ra,0x0
 84c:	f6e080e7          	jalr	-146(ra) # 7b6 <write>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6105                	addi	sp,sp,32
 856:	8082                	ret

0000000000000858 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 858:	7139                	addi	sp,sp,-64
 85a:	fc06                	sd	ra,56(sp)
 85c:	f822                	sd	s0,48(sp)
 85e:	f426                	sd	s1,40(sp)
 860:	f04a                	sd	s2,32(sp)
 862:	ec4e                	sd	s3,24(sp)
 864:	0080                	addi	s0,sp,64
 866:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 868:	c299                	beqz	a3,86e <printint+0x16>
 86a:	0805c963          	bltz	a1,8fc <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 86e:	2581                	sext.w	a1,a1
  neg = 0;
 870:	4881                	li	a7,0
 872:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 876:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 878:	2601                	sext.w	a2,a2
 87a:	00000517          	auipc	a0,0x0
 87e:	53e50513          	addi	a0,a0,1342 # db8 <digits>
 882:	883a                	mv	a6,a4
 884:	2705                	addiw	a4,a4,1
 886:	02c5f7bb          	remuw	a5,a1,a2
 88a:	1782                	slli	a5,a5,0x20
 88c:	9381                	srli	a5,a5,0x20
 88e:	97aa                	add	a5,a5,a0
 890:	0007c783          	lbu	a5,0(a5)
 894:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 898:	0005879b          	sext.w	a5,a1
 89c:	02c5d5bb          	divuw	a1,a1,a2
 8a0:	0685                	addi	a3,a3,1
 8a2:	fec7f0e3          	bgeu	a5,a2,882 <printint+0x2a>
  if(neg)
 8a6:	00088c63          	beqz	a7,8be <printint+0x66>
    buf[i++] = '-';
 8aa:	fd070793          	addi	a5,a4,-48
 8ae:	00878733          	add	a4,a5,s0
 8b2:	02d00793          	li	a5,45
 8b6:	fef70823          	sb	a5,-16(a4)
 8ba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8be:	02e05863          	blez	a4,8ee <printint+0x96>
 8c2:	fc040793          	addi	a5,s0,-64
 8c6:	00e78933          	add	s2,a5,a4
 8ca:	fff78993          	addi	s3,a5,-1
 8ce:	99ba                	add	s3,s3,a4
 8d0:	377d                	addiw	a4,a4,-1
 8d2:	1702                	slli	a4,a4,0x20
 8d4:	9301                	srli	a4,a4,0x20
 8d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8da:	fff94583          	lbu	a1,-1(s2)
 8de:	8526                	mv	a0,s1
 8e0:	00000097          	auipc	ra,0x0
 8e4:	f56080e7          	jalr	-170(ra) # 836 <putc>
  while(--i >= 0)
 8e8:	197d                	addi	s2,s2,-1
 8ea:	ff3918e3          	bne	s2,s3,8da <printint+0x82>
}
 8ee:	70e2                	ld	ra,56(sp)
 8f0:	7442                	ld	s0,48(sp)
 8f2:	74a2                	ld	s1,40(sp)
 8f4:	7902                	ld	s2,32(sp)
 8f6:	69e2                	ld	s3,24(sp)
 8f8:	6121                	addi	sp,sp,64
 8fa:	8082                	ret
    x = -xx;
 8fc:	40b005bb          	negw	a1,a1
    neg = 1;
 900:	4885                	li	a7,1
    x = -xx;
 902:	bf85                	j	872 <printint+0x1a>

0000000000000904 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 904:	7119                	addi	sp,sp,-128
 906:	fc86                	sd	ra,120(sp)
 908:	f8a2                	sd	s0,112(sp)
 90a:	f4a6                	sd	s1,104(sp)
 90c:	f0ca                	sd	s2,96(sp)
 90e:	ecce                	sd	s3,88(sp)
 910:	e8d2                	sd	s4,80(sp)
 912:	e4d6                	sd	s5,72(sp)
 914:	e0da                	sd	s6,64(sp)
 916:	fc5e                	sd	s7,56(sp)
 918:	f862                	sd	s8,48(sp)
 91a:	f466                	sd	s9,40(sp)
 91c:	f06a                	sd	s10,32(sp)
 91e:	ec6e                	sd	s11,24(sp)
 920:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 922:	0005c903          	lbu	s2,0(a1)
 926:	18090f63          	beqz	s2,ac4 <vprintf+0x1c0>
 92a:	8aaa                	mv	s5,a0
 92c:	8b32                	mv	s6,a2
 92e:	00158493          	addi	s1,a1,1
  state = 0;
 932:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 934:	02500a13          	li	s4,37
 938:	4c55                	li	s8,21
 93a:	00000c97          	auipc	s9,0x0
 93e:	426c8c93          	addi	s9,s9,1062 # d60 <malloc+0x198>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 942:	02800d93          	li	s11,40
  putc(fd, 'x');
 946:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 948:	00000b97          	auipc	s7,0x0
 94c:	470b8b93          	addi	s7,s7,1136 # db8 <digits>
 950:	a839                	j	96e <vprintf+0x6a>
        putc(fd, c);
 952:	85ca                	mv	a1,s2
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	ee0080e7          	jalr	-288(ra) # 836 <putc>
 95e:	a019                	j	964 <vprintf+0x60>
    } else if(state == '%'){
 960:	01498d63          	beq	s3,s4,97a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 964:	0485                	addi	s1,s1,1
 966:	fff4c903          	lbu	s2,-1(s1)
 96a:	14090d63          	beqz	s2,ac4 <vprintf+0x1c0>
    if(state == 0){
 96e:	fe0999e3          	bnez	s3,960 <vprintf+0x5c>
      if(c == '%'){
 972:	ff4910e3          	bne	s2,s4,952 <vprintf+0x4e>
        state = '%';
 976:	89d2                	mv	s3,s4
 978:	b7f5                	j	964 <vprintf+0x60>
      if(c == 'd'){
 97a:	11490c63          	beq	s2,s4,a92 <vprintf+0x18e>
 97e:	f9d9079b          	addiw	a5,s2,-99
 982:	0ff7f793          	zext.b	a5,a5
 986:	10fc6e63          	bltu	s8,a5,aa2 <vprintf+0x19e>
 98a:	f9d9079b          	addiw	a5,s2,-99
 98e:	0ff7f713          	zext.b	a4,a5
 992:	10ec6863          	bltu	s8,a4,aa2 <vprintf+0x19e>
 996:	00271793          	slli	a5,a4,0x2
 99a:	97e6                	add	a5,a5,s9
 99c:	439c                	lw	a5,0(a5)
 99e:	97e6                	add	a5,a5,s9
 9a0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9a2:	008b0913          	addi	s2,s6,8
 9a6:	4685                	li	a3,1
 9a8:	4629                	li	a2,10
 9aa:	000b2583          	lw	a1,0(s6)
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	ea8080e7          	jalr	-344(ra) # 858 <printint>
 9b8:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9ba:	4981                	li	s3,0
 9bc:	b765                	j	964 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9be:	008b0913          	addi	s2,s6,8
 9c2:	4681                	li	a3,0
 9c4:	4629                	li	a2,10
 9c6:	000b2583          	lw	a1,0(s6)
 9ca:	8556                	mv	a0,s5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	e8c080e7          	jalr	-372(ra) # 858 <printint>
 9d4:	8b4a                	mv	s6,s2
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	b771                	j	964 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9da:	008b0913          	addi	s2,s6,8
 9de:	4681                	li	a3,0
 9e0:	866a                	mv	a2,s10
 9e2:	000b2583          	lw	a1,0(s6)
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	e70080e7          	jalr	-400(ra) # 858 <printint>
 9f0:	8b4a                	mv	s6,s2
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	bf85                	j	964 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9f6:	008b0793          	addi	a5,s6,8
 9fa:	f8f43423          	sd	a5,-120(s0)
 9fe:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a02:	03000593          	li	a1,48
 a06:	8556                	mv	a0,s5
 a08:	00000097          	auipc	ra,0x0
 a0c:	e2e080e7          	jalr	-466(ra) # 836 <putc>
  putc(fd, 'x');
 a10:	07800593          	li	a1,120
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	e20080e7          	jalr	-480(ra) # 836 <putc>
 a1e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a20:	03c9d793          	srli	a5,s3,0x3c
 a24:	97de                	add	a5,a5,s7
 a26:	0007c583          	lbu	a1,0(a5)
 a2a:	8556                	mv	a0,s5
 a2c:	00000097          	auipc	ra,0x0
 a30:	e0a080e7          	jalr	-502(ra) # 836 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a34:	0992                	slli	s3,s3,0x4
 a36:	397d                	addiw	s2,s2,-1
 a38:	fe0914e3          	bnez	s2,a20 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a3c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a40:	4981                	li	s3,0
 a42:	b70d                	j	964 <vprintf+0x60>
        s = va_arg(ap, char*);
 a44:	008b0913          	addi	s2,s6,8
 a48:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a4c:	02098163          	beqz	s3,a6e <vprintf+0x16a>
        while(*s != 0){
 a50:	0009c583          	lbu	a1,0(s3)
 a54:	c5ad                	beqz	a1,abe <vprintf+0x1ba>
          putc(fd, *s);
 a56:	8556                	mv	a0,s5
 a58:	00000097          	auipc	ra,0x0
 a5c:	dde080e7          	jalr	-546(ra) # 836 <putc>
          s++;
 a60:	0985                	addi	s3,s3,1
        while(*s != 0){
 a62:	0009c583          	lbu	a1,0(s3)
 a66:	f9e5                	bnez	a1,a56 <vprintf+0x152>
        s = va_arg(ap, char*);
 a68:	8b4a                	mv	s6,s2
      state = 0;
 a6a:	4981                	li	s3,0
 a6c:	bde5                	j	964 <vprintf+0x60>
          s = "(null)";
 a6e:	00000997          	auipc	s3,0x0
 a72:	2ea98993          	addi	s3,s3,746 # d58 <malloc+0x190>
        while(*s != 0){
 a76:	85ee                	mv	a1,s11
 a78:	bff9                	j	a56 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a7a:	008b0913          	addi	s2,s6,8
 a7e:	000b4583          	lbu	a1,0(s6)
 a82:	8556                	mv	a0,s5
 a84:	00000097          	auipc	ra,0x0
 a88:	db2080e7          	jalr	-590(ra) # 836 <putc>
 a8c:	8b4a                	mv	s6,s2
      state = 0;
 a8e:	4981                	li	s3,0
 a90:	bdd1                	j	964 <vprintf+0x60>
        putc(fd, c);
 a92:	85d2                	mv	a1,s4
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	da0080e7          	jalr	-608(ra) # 836 <putc>
      state = 0;
 a9e:	4981                	li	s3,0
 aa0:	b5d1                	j	964 <vprintf+0x60>
        putc(fd, '%');
 aa2:	85d2                	mv	a1,s4
 aa4:	8556                	mv	a0,s5
 aa6:	00000097          	auipc	ra,0x0
 aaa:	d90080e7          	jalr	-624(ra) # 836 <putc>
        putc(fd, c);
 aae:	85ca                	mv	a1,s2
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	d84080e7          	jalr	-636(ra) # 836 <putc>
      state = 0;
 aba:	4981                	li	s3,0
 abc:	b565                	j	964 <vprintf+0x60>
        s = va_arg(ap, char*);
 abe:	8b4a                	mv	s6,s2
      state = 0;
 ac0:	4981                	li	s3,0
 ac2:	b54d                	j	964 <vprintf+0x60>
    }
  }
}
 ac4:	70e6                	ld	ra,120(sp)
 ac6:	7446                	ld	s0,112(sp)
 ac8:	74a6                	ld	s1,104(sp)
 aca:	7906                	ld	s2,96(sp)
 acc:	69e6                	ld	s3,88(sp)
 ace:	6a46                	ld	s4,80(sp)
 ad0:	6aa6                	ld	s5,72(sp)
 ad2:	6b06                	ld	s6,64(sp)
 ad4:	7be2                	ld	s7,56(sp)
 ad6:	7c42                	ld	s8,48(sp)
 ad8:	7ca2                	ld	s9,40(sp)
 ada:	7d02                	ld	s10,32(sp)
 adc:	6de2                	ld	s11,24(sp)
 ade:	6109                	addi	sp,sp,128
 ae0:	8082                	ret

0000000000000ae2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ae2:	715d                	addi	sp,sp,-80
 ae4:	ec06                	sd	ra,24(sp)
 ae6:	e822                	sd	s0,16(sp)
 ae8:	1000                	addi	s0,sp,32
 aea:	e010                	sd	a2,0(s0)
 aec:	e414                	sd	a3,8(s0)
 aee:	e818                	sd	a4,16(s0)
 af0:	ec1c                	sd	a5,24(s0)
 af2:	03043023          	sd	a6,32(s0)
 af6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 afa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 afe:	8622                	mv	a2,s0
 b00:	00000097          	auipc	ra,0x0
 b04:	e04080e7          	jalr	-508(ra) # 904 <vprintf>
}
 b08:	60e2                	ld	ra,24(sp)
 b0a:	6442                	ld	s0,16(sp)
 b0c:	6161                	addi	sp,sp,80
 b0e:	8082                	ret

0000000000000b10 <printf>:

void
printf(const char *fmt, ...)
{
 b10:	711d                	addi	sp,sp,-96
 b12:	ec06                	sd	ra,24(sp)
 b14:	e822                	sd	s0,16(sp)
 b16:	1000                	addi	s0,sp,32
 b18:	e40c                	sd	a1,8(s0)
 b1a:	e810                	sd	a2,16(s0)
 b1c:	ec14                	sd	a3,24(s0)
 b1e:	f018                	sd	a4,32(s0)
 b20:	f41c                	sd	a5,40(s0)
 b22:	03043823          	sd	a6,48(s0)
 b26:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b2a:	00840613          	addi	a2,s0,8
 b2e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b32:	85aa                	mv	a1,a0
 b34:	4505                	li	a0,1
 b36:	00000097          	auipc	ra,0x0
 b3a:	dce080e7          	jalr	-562(ra) # 904 <vprintf>
}
 b3e:	60e2                	ld	ra,24(sp)
 b40:	6442                	ld	s0,16(sp)
 b42:	6125                	addi	sp,sp,96
 b44:	8082                	ret

0000000000000b46 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b46:	1141                	addi	sp,sp,-16
 b48:	e422                	sd	s0,8(sp)
 b4a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b4c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b50:	00000797          	auipc	a5,0x0
 b54:	2807b783          	ld	a5,640(a5) # dd0 <freep>
 b58:	a02d                	j	b82 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b5a:	4618                	lw	a4,8(a2)
 b5c:	9f2d                	addw	a4,a4,a1
 b5e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b62:	6398                	ld	a4,0(a5)
 b64:	6310                	ld	a2,0(a4)
 b66:	a83d                	j	ba4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b68:	ff852703          	lw	a4,-8(a0)
 b6c:	9f31                	addw	a4,a4,a2
 b6e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b70:	ff053683          	ld	a3,-16(a0)
 b74:	a091                	j	bb8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b76:	6398                	ld	a4,0(a5)
 b78:	00e7e463          	bltu	a5,a4,b80 <free+0x3a>
 b7c:	00e6ea63          	bltu	a3,a4,b90 <free+0x4a>
{
 b80:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b82:	fed7fae3          	bgeu	a5,a3,b76 <free+0x30>
 b86:	6398                	ld	a4,0(a5)
 b88:	00e6e463          	bltu	a3,a4,b90 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8c:	fee7eae3          	bltu	a5,a4,b80 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b90:	ff852583          	lw	a1,-8(a0)
 b94:	6390                	ld	a2,0(a5)
 b96:	02059813          	slli	a6,a1,0x20
 b9a:	01c85713          	srli	a4,a6,0x1c
 b9e:	9736                	add	a4,a4,a3
 ba0:	fae60de3          	beq	a2,a4,b5a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ba4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ba8:	4790                	lw	a2,8(a5)
 baa:	02061593          	slli	a1,a2,0x20
 bae:	01c5d713          	srli	a4,a1,0x1c
 bb2:	973e                	add	a4,a4,a5
 bb4:	fae68ae3          	beq	a3,a4,b68 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bb8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bba:	00000717          	auipc	a4,0x0
 bbe:	20f73b23          	sd	a5,534(a4) # dd0 <freep>
}
 bc2:	6422                	ld	s0,8(sp)
 bc4:	0141                	addi	sp,sp,16
 bc6:	8082                	ret

0000000000000bc8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc8:	7139                	addi	sp,sp,-64
 bca:	fc06                	sd	ra,56(sp)
 bcc:	f822                	sd	s0,48(sp)
 bce:	f426                	sd	s1,40(sp)
 bd0:	f04a                	sd	s2,32(sp)
 bd2:	ec4e                	sd	s3,24(sp)
 bd4:	e852                	sd	s4,16(sp)
 bd6:	e456                	sd	s5,8(sp)
 bd8:	e05a                	sd	s6,0(sp)
 bda:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bdc:	02051493          	slli	s1,a0,0x20
 be0:	9081                	srli	s1,s1,0x20
 be2:	04bd                	addi	s1,s1,15
 be4:	8091                	srli	s1,s1,0x4
 be6:	0014899b          	addiw	s3,s1,1
 bea:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 bec:	00000517          	auipc	a0,0x0
 bf0:	1e453503          	ld	a0,484(a0) # dd0 <freep>
 bf4:	c515                	beqz	a0,c20 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bf6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bf8:	4798                	lw	a4,8(a5)
 bfa:	02977f63          	bgeu	a4,s1,c38 <malloc+0x70>
 bfe:	8a4e                	mv	s4,s3
 c00:	0009871b          	sext.w	a4,s3
 c04:	6685                	lui	a3,0x1
 c06:	00d77363          	bgeu	a4,a3,c0c <malloc+0x44>
 c0a:	6a05                	lui	s4,0x1
 c0c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c10:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c14:	00000917          	auipc	s2,0x0
 c18:	1bc90913          	addi	s2,s2,444 # dd0 <freep>
  if(p == (char*)-1)
 c1c:	5afd                	li	s5,-1
 c1e:	a895                	j	c92 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c20:	00000797          	auipc	a5,0x0
 c24:	1c878793          	addi	a5,a5,456 # de8 <base>
 c28:	00000717          	auipc	a4,0x0
 c2c:	1af73423          	sd	a5,424(a4) # dd0 <freep>
 c30:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c32:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c36:	b7e1                	j	bfe <malloc+0x36>
      if(p->s.size == nunits)
 c38:	02e48c63          	beq	s1,a4,c70 <malloc+0xa8>
        p->s.size -= nunits;
 c3c:	4137073b          	subw	a4,a4,s3
 c40:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c42:	02071693          	slli	a3,a4,0x20
 c46:	01c6d713          	srli	a4,a3,0x1c
 c4a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c4c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c50:	00000717          	auipc	a4,0x0
 c54:	18a73023          	sd	a0,384(a4) # dd0 <freep>
      return (void*)(p + 1);
 c58:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c5c:	70e2                	ld	ra,56(sp)
 c5e:	7442                	ld	s0,48(sp)
 c60:	74a2                	ld	s1,40(sp)
 c62:	7902                	ld	s2,32(sp)
 c64:	69e2                	ld	s3,24(sp)
 c66:	6a42                	ld	s4,16(sp)
 c68:	6aa2                	ld	s5,8(sp)
 c6a:	6b02                	ld	s6,0(sp)
 c6c:	6121                	addi	sp,sp,64
 c6e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c70:	6398                	ld	a4,0(a5)
 c72:	e118                	sd	a4,0(a0)
 c74:	bff1                	j	c50 <malloc+0x88>
  hp->s.size = nu;
 c76:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c7a:	0541                	addi	a0,a0,16
 c7c:	00000097          	auipc	ra,0x0
 c80:	eca080e7          	jalr	-310(ra) # b46 <free>
  return freep;
 c84:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c88:	d971                	beqz	a0,c5c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c8a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c8c:	4798                	lw	a4,8(a5)
 c8e:	fa9775e3          	bgeu	a4,s1,c38 <malloc+0x70>
    if(p == freep)
 c92:	00093703          	ld	a4,0(s2)
 c96:	853e                	mv	a0,a5
 c98:	fef719e3          	bne	a4,a5,c8a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c9c:	8552                	mv	a0,s4
 c9e:	00000097          	auipc	ra,0x0
 ca2:	b80080e7          	jalr	-1152(ra) # 81e <sbrk>
  if(p == (char*)-1)
 ca6:	fd5518e3          	bne	a0,s5,c76 <malloc+0xae>
        return 0;
 caa:	4501                	li	a0,0
 cac:	bf45                	j	c5c <malloc+0x94>
