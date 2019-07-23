-- 攻击数据

--[[
struct AttackingObject
{
	cocos2d::CCSprite*	pSprite;
	e_WeaponType		type;
	float				x;
	float				y;
	float				w;
	float				h;
	float				vx;
	float				vy;
	int					toward;
	float				speed;
	float				range;
	float				rotation;
	int					damage;
	int					time;
	int					life;
	int					index;
	int					isFirst;
	bool				wall;

	AttackingObject()
	{
		pSprite = NULL;
		life	= -1;
		isFirst	= 1;
		wall	= true;
	}
};
]]