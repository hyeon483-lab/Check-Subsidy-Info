import type { Locale } from "./config";

/**
 * Localized names and one-line descriptions for lib/seedData.ts's
 * seedCategories entries. Keyed by each category's `slug` field.
 */
export const categoryNames: Record<Exclude<Locale, "ko">, Record<string, { name: string; description: string }>> = {
  en: {
    marriage: {
      name: "Marriage",
      description: "Support programs for couples preparing for marriage or newlyweds.",
    },
    birth: {
      name: "Pregnancy & Childcare",
      description: "Programs covering pregnancy, childbirth, and raising young children.",
    },
    "child-youth": {
      name: "Children & Teens",
      description: "Support programs for children and teens (ages 7-18) and their families.",
    },
    youth: {
      name: "Young Adults",
      description: "Support programs for young adults (roughly ages 19-39).",
    },
    housing: {
      name: "Housing",
      description: "Support programs for rent, deposits, and home purchases.",
    },
    senior: {
      name: "Seniors",
      description: "Support programs for seniors aged 65 and older.",
    },
    multicultural: {
      name: "Multicultural Families",
      description: "Support programs for foreign residents and multicultural families in Korea.",
    },
  },
  ja: {
    marriage: {
      name: "結婚",
      description: "結婚準備中のカップルや新婚夫婦を支援する制度です。",
    },
    birth: {
      name: "妊娠・出産・育児",
      description: "妊娠、出産、育児に関する支援制度です。",
    },
    "child-youth": {
      name: "子供・青少年",
      description: "満7〜18歳の子供・青少年とその家庭を支援する制度です。",
    },
    youth: {
      name: "青年",
      description: "青年(おおむね満19〜39歳)を対象とした支援制度です。",
    },
    housing: {
      name: "住居",
      description: "賃貸や住宅購入に関する支援制度です。",
    },
    senior: {
      name: "高齢者",
      description: "満65歳以上の高齢者を対象とした支援制度です。",
    },
    multicultural: {
      name: "多文化家庭",
      description: "国内在留外国人や多文化家庭を支援する制度です。",
    },
  },
  zh: {
    marriage: {
      name: "结婚",
      description: "为准备结婚的情侣和新婚夫妇提供的支持项目。",
    },
    birth: {
      name: "孕产育儿",
      description: "涵盖怀孕、生育与育儿的支持项目。",
    },
    "child-youth": {
      name: "儿童青少年",
      description: "面向7至18岁儿童青少年及其家庭的支持项目。",
    },
    youth: {
      name: "青年",
      description: "面向青年(约19至39岁)的支持项目。",
    },
    housing: {
      name: "住房",
      description: "涉及租房押金与购房的支持项目。",
    },
    senior: {
      name: "老年人",
      description: "面向65岁以上老年人的支持项目。",
    },
    multicultural: {
      name: "多元文化家庭",
      description: "面向在韩外国人及多元文化家庭的支持项目。",
    },
  },
  vi: {
    marriage: {
      name: "Kết hôn",
      description: "Chương trình hỗ trợ các cặp đôi chuẩn bị kết hôn và vợ chồng mới cưới.",
    },
    birth: {
      name: "Mang thai & Nuôi con",
      description: "Chương trình hỗ trợ liên quan đến mang thai, sinh con và nuôi dạy trẻ nhỏ.",
    },
    "child-youth": {
      name: "Trẻ em & Thanh thiếu niên",
      description: "Chương trình hỗ trợ trẻ em, thanh thiếu niên (7-18 tuổi) và gia đình các em.",
    },
    youth: {
      name: "Thanh niên",
      description: "Chương trình hỗ trợ dành cho thanh niên (khoảng 19-39 tuổi).",
    },
    housing: {
      name: "Nhà ở",
      description: "Chương trình hỗ trợ tiền thuê nhà, tiền đặt cọc và mua nhà.",
    },
    senior: {
      name: "Người cao tuổi",
      description: "Chương trình hỗ trợ dành cho người cao tuổi từ 65 tuổi trở lên.",
    },
    multicultural: {
      name: "Gia đình đa văn hóa",
      description: "Chương trình hỗ trợ người nước ngoài cư trú tại Hàn Quốc và gia đình đa văn hóa.",
    },
  },
  th: {
    marriage: {
      name: "การแต่งงาน",
      description: "โครงการสนับสนุนคู่รักที่เตรียมแต่งงานและคู่แต่งงานใหม่",
    },
    birth: {
      name: "ตั้งครรภ์และเลี้ยงดูบุตร",
      description: "โครงการสนับสนุนด้านการตั้งครรภ์ การคลอดบุตร และการเลี้ยงดูบุตร",
    },
    "child-youth": {
      name: "เด็กและเยาวชน",
      description: "โครงการสนับสนุนเด็กและเยาวชนอายุ 7-18 ปี รวมถึงครอบครัว",
    },
    youth: {
      name: "คนหนุ่มสาว",
      description: "โครงการสนับสนุนคนหนุ่มสาว (อายุประมาณ 19-39 ปี)",
    },
    housing: {
      name: "ที่อยู่อาศัย",
      description: "โครงการสนับสนุนค่าเช่า เงินมัดจำ และการซื้อที่อยู่อาศัย",
    },
    senior: {
      name: "ผู้สูงอายุ",
      description: "โครงการสนับสนุนผู้สูงอายุตั้งแต่ 65 ปีขึ้นไป",
    },
    multicultural: {
      name: "ครอบครัวพหุวัฒนธรรม",
      description: "โครงการสนับสนุนชาวต่างชาติที่พำนักในเกาหลีและครอบครัวพหุวัฒนธรรม",
    },
  },
};
