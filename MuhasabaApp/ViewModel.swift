//
//  ViewModel.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 12/25/23.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class ViewModel {
    var mathuratcards: [MathuratCardData]
    var userSettings: UserSettings
//    var habits: Habits
    var tableRows: [GridItem]
    
    init(mathuratcards: [MathuratCardData] = [], userSettings: UserSettings = UserSettings()) {
        self.mathuratcards = mathuratcards
        self.userSettings = userSettings
        self.tableRows = Array(repeating: GridItem(.flexible()), count: userSettings.numHabits)
        
        var newCard = MathuratCardData(title: "Al Fatihah", arabicText: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ‎﴿١﴾‏ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ‎﴿٢﴾‏ الرَّحْمَٰنِ الرَّحِيمِ ‎﴿٣﴾‏ مَالِكِ يَوْمِ الدِّينِ ‎﴿٤﴾‏ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ‎﴿٥﴾‏ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ‎﴿٦﴾‏ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ‎﴿٧﴾‏", transliteration: "Bismi Allahi arrahmani arraheem (1) Alhamdu lillahi rabbi alAAalameen (2) Arrahmani arraheem (3) Maliki yawmi addeen (4) Iyyaka naAAbudu wa-iyyaka nastaAAeen (5) Ihdina assirata almustaqeem (6) Sirata allatheena anAAamta AAalayhim ghayri almaghdoobi AAalayhim wala addalleen (7)", translation: "In the name of Allah, the Entirely Merciful, the Especially Merciful. (1) [All] praise is [due] to Allah, Lord of the worlds - (2) The Entirely Merciful, the Especially Merciful, (3) Sovereign of the Day of Recompense. (4) It is You we worship and You we ask for help. (5) Guide us to the straight path - (6) The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray. (7)", count: 1)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "Al Baqarah", arabicText: "الم ‎﴿١﴾‏ ذَٰلِكَ الْكِتَابُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ ‎﴿٢﴾‏ الَّذِينَ يُؤْمِنُونَ بِالْغَيْبِ وَيُقِيمُونَ الصَّلَاةَ وَمِمَّا رَزَقْنَاهُمْ يُنفِقُونَ ‎﴿٣﴾‏ وَالَّذِينَيُؤْمِنُونَ بِمَا أُنزِلَ إِلَيْكَ وَمَا أُنزِلَ مِن قَبْلِكَ وَبِالْآخِرَةِ هُمْ يُوقِنُونَ ‎﴿٤﴾‏ أُولَٰئِكَ عَلَىٰ هُدًى مِّن رَّبِّهِمْ ۖ وَأُولَٰئِكَ هُمُ الْمُفْلِحُونَ ‎﴿٥﴾‏", transliteration: "Alif-lam-meem (1) Thalika alkitabu larayba feehi hudan lilmuttaqeen (2) Allatheena yu/minoona bilghaybiwayuqeemoona assalata wamimma razaqnahumyunfiqoon (3) Wallatheena yu/minoona bimaonzila ilayka wama onzila min qablika wabil-akhiratihum yooqinoon (4) Ola-ika AAala hudan minrabbihim waola-ika humu almuflihoon (5) Inna allatheena kafaroo sawaonAAalayhim aanthartahum am lam tunthirhum layu/minoon (6)", translation: "Alif, Lam, Meem. (1) This is the Book about which there is no doubt, a guidance for those conscious of Allah - (2) Who believe in the unseen, establish prayer, and spend out of what We have provided for them, (3) And who believe in what has been revealed to you, [O Muhammad], and what was revealed before you, and of the Hereafter they are certain [in faith]. (4) Those are upon [right] guidance from their Lord, and it is those who are the successful. (5)", count: 1)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "Ayatul Kursi", arabicText: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ ‎﴿٢٥٥﴾‏ لَا إِكْرَاهَ فِي الدِّينِ ۖ قَد تَّبَيَّنَ الرُّشْدُ مِنَ الْغَيِّ ۚ فَمَن يَكْفُرْ بِالطَّاغُوتِ وَيُؤْمِن بِاللَّهِ فَقَدِ اسْتَمْسَكَ بِالْعُرْوَةِ الْوُثْقَىٰ لَا انفِصَامَ لَهَا ۗ وَاللَّهُ سَمِيعٌ عَلِيمٌ ‎﴿٢٥٦﴾ اللَّهُ وَلِيُّ الَّذِينَ آمَنُوا يُخْرِجُهُم مِّنَ الظُّلُمَاتِ إِلَى النُّورِ ۖ وَالَّذِينَ كَفَرُوا أَوْلِيَاؤُهُمُ الطَّاغُوتُ يُخْرِجُونَهُم مِّنَ النُّورِ إِلَى الظُّلُمَاتِ ۗ أُولَٰئِكَ أَصْحَابُ النَّارِ ۖ هُمْ فِيهَا خَالِدُونَ ‎﴿٢٥٧﴾‏", translation: "Allah! There is no god but He, the Living, the Sustainer. Neither slumber nor sleep overtakes Him. His is what is in the heavens and what is in the earth. Who can intercede with Him except by his permission? He knows what is before them and behind them and they can grasp only that part of His knowledge He wills. His Throne embraces the heavens and the earth and it tires Him not to uphold both. For He is the Most High, the Formidable. Let there be no compulsion in religion. True guidance has become distinct from error. But whoever disbelieves in false gods and believes in Allah, has grasped the most strong handhold that will never break. And Allah is Hearing, Knowing. Allah is the Protector of those who believe. He brings them out of the darkness and into light. As for those who disbelieve, their supporters will be false gods, who bring them out of the light into darkness. Such are the dwellers of the Fire, abiding therein perpetually. (Quran 2:255 - 257)", count: 1)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "End of Baqarah", arabicText: "لِّلَّهِ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ وَإِن تُبْدُوا مَا فِي أَنفُسِكُمْ أَوْ تُخْفُوهُ يُحَاسِبْكُم بِهِ اللَّهُ ۖ فَيَغْفِرُ لِمَن يَشَاءُ وَيُعَذِّبُ مَن يَشَاءُ ۗ وَاللَّهُ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ ‎﴿٢٨٤﴾‏ آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ ‎﴿٢٨٥﴾‏ لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ ۖ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا ۚ أَنتَ مَوْلَانَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ ‎﴿٢٨٦﴾‏", translation: "To Allah belongs all that the heavens and all that the earth contains. Whether you make known what is in your souls or hide it, Allah will bring you to account for it. He forgives whom He will and punishes whom He will; Allah has power over all things. The Messenger believes in what has been sent down to him by his Lord, and so do the believers. They all believe in Allah and His angels, His books and his Messengers: “We make no distinction (they say) between any of His Messengers.” And they say: “We hear and we obey. Grant us Your forgiveness, our Lord; to You is the end of all journeys.” On no soul does Allah place a burden greater than it can bear. It shall be requited for whatever good and whatever evil it has done: “Our Lord! Condemn us not if we forget or fall into error; Our Lord! Lay not on us a burden greater than we have strength to bear. Pardon us, forgive us, and have mercy on us. You are our Protector; so give us victory over the disbelieving people. (Quran 2:284 - 86)", count: 1)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "Al Ikhlas", arabicText: "قُلْ هُوَ اللَّهُ أَحَدٌ ‎﴿١﴾‏ اللَّهُ الصَّمَدُ ‎﴿٢﴾‏ لَمْ يَلِدْ وَلَمْ يُولَدْ ‎﴿٣﴾‏ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ ‎﴿٤﴾", transliteration: "qulhuAllahu ahad", translation: "Say, \"He is Allah, [who is] One, (1) Allah, the Eternal Refuge. (2) He neither begets nor is born, (3) Nor is there to Him any equivalent.\" (4)")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "Al Falaq", arabicText: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ‎﴿١﴾‏ مِن شَرِّ مَا خَلَقَ ‎﴿٢﴾‏ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ‎﴿٣﴾‏ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ‎﴿٤﴾‏ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ ‎﴿٥﴾‏", translation: "Say, \"I seek refuge in the Lord of daybreak (1) From the evil of that which He created (2) And from the evil of darkness when it settles (3) And from the evil of the blowers in knots (4) And from the evil of an envier when he envies.\" (5)")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(title: "An Nas", arabicText: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ ‎﴿١﴾‏ مَلِكِ النَّاسِ ‎﴿٢﴾‏ إِلَٰهِ النَّاسِ ‎﴿٣﴾‏ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ‎﴿٤﴾‏ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ‎﴿٥﴾‏ مِنَ الْجِنَّةِ وَالنَّاسِ ‎﴿٦﴾‏", translation: "Say, \"I seek refuge in the Lord of mankind, (1) The Sovereign of mankind. (2) The God of mankind, (3) From the evil of the retreating whisperer - (4) Who whispers [evil] into the breasts of mankind - (5) From among the jinn and mankind.\" (6)")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "أَصبَحنَا وأَصبَحَ الُملكُ لله، والحَمدُ للهِ لا شَرِيكَ لَه، لا إلَهَ إلَّا هُوَ وإِلَيهِ النُشُور", translation: "Morning has risen upon us and sovereignty is all Allah’s. Praise is due to Allah alone, He has no partner. There is no god but Him, unto Whom is the return", nightText: "أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله لا شَرِيكَ لَه، لا إلَهَ إلَّا هُوَ وإِلَيهِ الْمَصِيرُ", nightTranslation: "The evening has risen upon us and sovereignty is all Allah’s. Praise is due to Allah alone, He has no partner. There is no god but Him, unto Whom is the return", hasNight: true)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "أَصبَحنَا عَلَى فِطرَةِ الِإسلَام، وكَلِمَةِ الِإخلَاص، وعَلَى دِينِ نَبيِّنَا مُحمَّدٍ صَلَّى اللهُ عَلَيهِ وسَلَّم، وعَلَى مِلَّةِ أَبِينَا إِبرَاهِيمَ حَنِيفًا، ومَا كَانَ مِنَ المُشرِكِين", translation: "We have risen this morning on this innate nature of Islam, on the Word of Sincerity, and on the den (way of life) of our Prophet Muhammad (s) and on the deen of our forefather Ibraheem, who was a Muslim of true faith and was not an idolater.", nightText: "أَمْسَيْنَا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً وَمَا كَانَ مِنَ المُشْرِكِينَ", nightTranslation: "We have risen this evening on this innate nature of Islam, on the Word of Sincerity, and on the den (way of life) of our Prophet Muhammad (s) and on the deen of our forefather Ibraheem, who was a Muslim of true faith and was not an idolater.", hasNight: true)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "أَصبَحنَا عَلَى فِطرَةِ الِإسلَام، وكَلِمَةِ الِإخلَاص، وعَلَى دِينِ نَبيِّنَا مُحمَّدٍ صَلَّى اللهُ عَلَيهِ وسَلَّم، وعَلَى مِلَّةِ أَبِينَا إِبرَاهِيمَ حَنِيفًا، ومَا كَانَ مِنَ المُشرِكِين", translation: "We have risen this morning on this innate nature of Islam, on the Word of Sincerity, and on the den (way of life) of our Prophet Muhammad (s) and on the deen of our forefather Ibraheem, who was a Muslim of true faith and was not an idolater.", nightText: "أَمْسَيْنَا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً وَمَا كَانَ مِنَ المُشْرِكِينَ", nightTranslation: "We have risen this evening on this innate nature of Islam, on the Word of Sincerity, and on the den (way of life) of our Prophet Muhammad (s) and on the deen of our forefather Ibraheem, who was a Muslim of true faith and was not an idolater.", hasNight: true)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ إِنِّي أَصبَحتُ مِنكَ فِي نِعمَةٍ وعَافِيَةٍ وسِتر، فَأَتِمَّ عَلَيَّ نِعمَتَكَ وعَافِيَتَكَ وسِترَكَ فِي الدُنيَا والآَخِرَة", translation: "O Allah! I rise up in the morning with blessing, strength and protection, all of which You have bestowed upon me. So complete Your blessing, the strength (You have bestowed upon me) and Your protection, in this life and in the Hereafter.", nightText: "اللَّهُمَّ إِنِّي أَمسيتُ مِنكَ فِي نِعمَةٍ وعَافِيَةٍ وسِتر، فَأَتِمَّ عَلَيَّ نِعمَتَكَ وعَافِيَتَكَ وسِترَكَ فِي الدُنيَا والآَخِرَة", nightTranslation: "O Allah! I have received an evening of blessing, strength and protection, all of which You have bestowed upon me. So complete Your blessing, the strength (You have bestowed upon me) and Your protection, in this life and in the Hereafter.", hasNight: true)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ مَا أَصبَحَ بِي مِن نِعمَةٍ أو بِأَحَدٍ مِن خَلقِكَ فَمِنكَ وَحدَكَ لا شَرِيكَ لَك، فَلَكَ الحَمدُ، ولَكَ الشُّكر", translation: "O Allah! Whatever blessing I, or any of Your other creatures, rise up with, is only from Your. You have no partner, so all praises and thanks are due to You", nightText: "اللّهُـمَّ ما أَمسى بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر", nightTranslation: "O Allah! Whatever blessing I, or any of Your other creatures, rise up with, is only from Your. You have no partner, so all praises and thanks are due to You", hasNight: true)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "يَا رَبي لَكَ الحَمدُ كَمَا يَنبَغِي لِجَلَالِ وَجهِكَ وَعَظِيمِ سُلطَانِك", translation: "O My lord! All praise is due to You as is befitting to Your glorious presence and Your great sovereignty")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "رَضِيتُ بِاللهِ رَبًا، وبِالِإسلَامِ دِينَا، وبِمُحمَّدٍ صَلَّى اللهُ عَلَيهِ وسَلَّمَ نَبِيَّا ورَسُولَا", translation: "I have accepted Allah as Lord, Islam as a way of life and Muhammad (s) as a prophet and Messenger (of Allah)")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ", translation: "In the Name of Allah, with Whose Name nothing on earth or in heaven can cause any harm and He is the All-Hearer, the All-Knower")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ إنَّا نَعُوذُ بِكَ مِن أَن نُشرِكَ بِكَ شَيئًا نَعلَمُه، ونَستَغفِرُكَ لِما لا نَعلَمُه", translation: "O Allah! We seek Your protection from knowingly associating others with You and we seek Your forgiveness from associating others with You unknowingly")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "أَعُوذُ بِكَلِمَاتِ اللهِ التَّامَّاتِ مِن شَرِّ مَا خَلَق", translation: "I seek refuge in the perfect words of Allah from the evil of that which He has created")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الهَمِّ والحَزَن، وأَعُوذُ بِكَ مِنَ العَجزِ والكَسَل، وأَعُوذُ بِكَ مِنَ الجُبنِ والبُخل، وأَعُوذُ بِكَ مِن غَلَبَةِ الدَينِ وقَهرِ الرِجَال", translation: "O Allah! I seek Your protection from anxiety and sorrow, and I seek Your protection from helplessness and laziness, and I seek Your protection from cowardice and miserliness, and I seek Your protection from the burden of debts and the tyranny of men")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ عَافِنِي فِى بَدَنِي، اللَّهُمَّ عَافِنِي فِى سَمعِي، اللَّهُمَّ عَافِنِي فِى بَصَرِي، لا إلَه إلَّا أَنت", translation: "O Allah! Grant health to my body. O Allah! Grant health to my hearing. O Allah! Grant health to my sight. None has the right to be worshiped except you")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ إنِّي أَعُوذُ بِكَ مِنَ الكُفرِ والفَقر، اللَّهُمَّ إنِّي أَعُوذُ بِكَ مِن عَذَابِ القَبر، لا إلَه إلَّا أَنت", translation: "O Allah! I seek Your protection from disbelief and poverty, and I seek Your protection from the punishment of the grave. None has the right to be worshiped except you")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ أَنتَ ربِّي لا إلَه إلَّا أَنتَ، خَلَقتَنِي وأَنَا عَبدُك وأَنَا عَلَى عَهدِكَ ووَعدِكَ مَا استَطَعت، أَعُوذُ بِكَ مِن شَرِّ مَا صَنَعت، أَبُوءُ لَكَ بِنِعمَتِكَ عَليَّ وأَبُوءُ بِذَنبِي، فَاغفِر لِي، فَإنَّهُ لا يَغفِرُ الذُّنُوبَ إلَّا أَنت", translation: "O Allah! You are my Lord, there is no god but You. You created me and I am your slave, and I uphold Your pledge and promise as best as I can. I seek Your protection against the evil that I have committed. I acknowledge your blessing upon me and I acknowledge my sin. So forgive me, for none can forgive sins except You")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "أَستَغفِرُ اللهَ الَّذِي لا إلَه إلَّا هُوَ الحَيَّ القَيُّومَ وأَتُوبُ إلَيه", translation: "I seek forgiveness from Allah, none has the right to be worshiped except Him, the Living, the Eternal and I repent to Him")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وعلى آلِ سيِّدِنَا مُحَمَّد كَمَا صَلَّيتَ عَلَى سَيِّدِنَا إبرَاهِيمَ وعَلَى آلِ سَيِّدِنَا إبرَاهِيم وبَارِك عَلَى سَيِّدِنَا مُحَمَّدٍ وعَلَى آلِ سَيِّدِنَا مُحَمَّد كَمَا بَارَكتَ عَلَى سَيِّدِنَا إبرَاهِيمَ وعَلَى آلِ سَيِّدنَا إبرَاهِيمَ فِى العَالَمِينَ، إنَّكَ حَمِيدٌ مَجِيد", translation: "O Allah! Exalt and have mercy on Muhammad and on the family of Muhammad as You had mercy on Ibraheem and on the family of Ibraheem. And bless our master Muhammad and the family of our master Muhammad as You blessed our master Ibraheem and the family of our master iBraheem in this universe. Indeed, You are Gracious, Glorious")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "سُبحَانَ اللهِ والحَمدُ للهِ ولا إلَه إلَّا اللهُ واللهُ أَكبَر", translation: "Glory be to Allah; Praise is due to Allah; and there is no god but Allah and Allah is the greatest", count: 10)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "لا إلَه إلَّا اللهُ وَحدَهُ لا شَرِيكَ لَه، لَهُ المُلكُ ولَهُ الحَمد، وهُوَ عَلَى كُلِّ شَئٍ قَدِير", translation: "There is no god but Allah alone. He has no partner. Sovereignty and Praise are His; and He is Omnipotent.")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "سُبحَانَكَ اللَّهُمَّ وبِحَمدِك، أَشهَدُ أَن لَا إلَه إلَّا أَنت، أَستَغفِرُكَ وأَتُوبُ إلَيك", translation: "Glory and all Praise be to you O Allah! I testify that there is no god but Your. I seek Your forgiveness and to You do I repent")
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "اللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ عبدكَ ونَبِيِّكَ ورَسُولِكَ النَبِيِّ الأُمِيِّ وعَلَى آلِهِ وصَحبِهِ وسَلِّم", translation: "O Allah! Exalt our master Muhammad, Your servant, Your Prophet, Your Messenger, the unlettered Prophet and on his family and companions", count: 1)
        self.mathuratcards.append(newCard)
        
        newCard = MathuratCardData(arabicText: "سُبحَانَ رَبِّكَ رَبِّ العِزَّةِ عَمَّا يَصِفُون، وسَلَامٌ عَلَى المُرسَلِين، والحَمدُ للهِ رَبِّ العَالَمِين", translation: "Glory be to You O Lord! The Lord of Honor and Power, who is free from what they ascribe to Him. May peace be upon the messengers and all praise is due to Allah, the Lord and Sustainer of the worlds", count: 1)
        self.mathuratcards.append(newCard)
    }
    
}

//@Model
@Observable
class UserSettings {
    
    var isNight: Bool
    var showTransliteration: Bool
    var showTranslation: Bool
    var numHabits: Int
    
    init(isNight: Bool = false, showTransliteration: Bool = false, showTranslation: Bool = true) {
        self.isNight = isNight
        self.showTransliteration = showTransliteration
        self.showTranslation = showTranslation
        self.numHabits = 8
    }
}

@Observable
class MathuratCardData: Identifiable {
    let id = UUID()
    var title: String
    var arabicText: String
    var transliteration: String
    var translation: String
    var nightText: String
    var nightTranslation: String
    var hasNight: Bool
    var count: Int
    
    init(title: String = "", arabicText: String = "", transliteration: String = "", translation: String = "", nightText: String = "", nightTranslation: String = "", hasNight: Bool = false, showTransliteration: Bool = false, showTranslation: Bool = false, notes: String = "", count: Int = 3) {
        self.title = title
        self.arabicText = arabicText
        self.transliteration = transliteration
        self.translation = translation
        self.nightText = nightText
        self.hasNight = hasNight
        self.showTransliteration = showTransliteration
        self.showTranslation = showTranslation
        self.notes = notes
        self.nightTranslation = nightTranslation
        self.count = count
    }
    
    var showTransliteration = false
    var showTranslation = false
    
    let recitation = ""
    var notes = ""
    
    func adjustCard(showTransliteration: Bool, showTranslation: Bool) {
        self.showTransliteration = showTransliteration
        self.showTranslation = showTranslation
    }
}

@Observable
class Habits {
    var habitName: String
    
    init(habitName: String = "") {
        self.habitName = habitName
    }
}
