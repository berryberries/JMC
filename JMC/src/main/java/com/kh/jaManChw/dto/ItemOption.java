package com.kh.jaManChw.dto;

public class ItemOption {

	private int itemOptionno;
	private int itemno;
	private String optionContent;
	private int optionCount;
	private double extraCharge;
	
	public ItemOption() {}

	public ItemOption(int itemOptionno, int itemno, String optionContent, int optionCount, double extraCharge) {
		super();
		this.itemOptionno = itemOptionno;
		this.itemno = itemno;
		this.optionContent = optionContent;
		this.optionCount = optionCount;
		this.extraCharge = extraCharge;
	}

	@Override
	public String toString() {
		return "ItemOption [itemOptionno=" + itemOptionno + ", itemno=" + itemno + ", optionContent=" + optionContent
				+ ", optionCount=" + optionCount + ", extraCharge=" + extraCharge + "]";
	}

	public int getItemOptionno() {
		return itemOptionno;
	}

	public void setItemOptionno(int itemOptionno) {
		this.itemOptionno = itemOptionno;
	}

	public int getItemno() {
		return itemno;
	}

	public void setItemno(int itemno) {
		this.itemno = itemno;
	}

	public String getOptionContent() {
		return optionContent;
	}

	public void setOptionContent(String optionContent) {
		this.optionContent = optionContent;
	}

	public int getOptionCount() {
		return optionCount;
	}

	public void setOptionCount(int optionCount) {
		this.optionCount = optionCount;
	}

	public double getExtraCharge() {
		return extraCharge;
	}

	public void setExtraCharge(double extraCharge) {
		this.extraCharge = extraCharge;
	}

}
