CREATE TABLE `member_activator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL COMMENT '�|�� ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '�ҥΪ��N�X',
  `type` tinyint(1) NOT NULL COMMENT '���U�����A1: email, 2: ������X',
  `created_at` datetime DEFAULT NULL COMMENT '�إߤ��',
  `updated_at` datetime DEFAULT NULL COMMENT '��s���',
  PRIMARY KEY (`id`),
  KEY `idx_member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '�y���� ID',
  `reg_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '�|�����U email',
  `reg_phone` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '�|�����U������X',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` tinyint(1) DEFAULT 0 COMMENT '�ʧO�A0:����g, 1:�k��, 2:�k��, 3:��ʧO',
  `type` tinyint(1) NOT NULL COMMENT '���U�����A1: email, 2: ������X',
  `reg_date` datetime DEFAULT NULL COMMENT '���U����ɶ�',
  `updated_at` datetime DEFAULT NULL COMMENT '��s����ɶ�',
  `status` tinyint(1) DEFAULT 0 COMMENT '�|�����A�A0: ���ҥ�, 1:�ҥ�, 2:�¦W��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`reg_email`),
  UNIQUE KEY `reg_phone_UNIQUE` (`reg_phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='�|����ƪ�';
