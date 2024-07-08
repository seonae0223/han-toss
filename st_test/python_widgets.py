# -*- coding:utf-8 -*-

import streamlit as st 
import pandas as pd 
import matplotlib.pyplot as plt 
import seaborn as sns 
import plotly 
import numpy as np 
import streamlit.components.v1 as components # JavaScript 개발용

@st.cache_data
def get_data():
    data = sns.load_dataset("tips")
    return data

def main():
    price = st.slider("단가 : ", 1000, 10000, value = 5000)
    total_sales = st.slider("전체 판매 갯수:", 1, 1000, value = 500)

    if st.button("매출액 계산"):
        revenue = price * total_sales
        st.write(f"전체매출액 : {revenue}")

    tips = get_data()
    st.dataframe(tips.head())

    show_plot = st.checkbox("시각화를 보여줄까요?")

    tip_max = tips['tip'].max() # tip의 최대
    tip_min = tips['tip'].min() # tip의 최소
    tip = st.slider("tip의 입력값 : ",tip_min, tip_max)
    #tips2 = tips.loc[tips['tip'] >= tip, :]

    option = st.selectbox("요일을 선택하세요", ("Thur", "Fri", "Sun", "Sat"))
    st.write(option)

    # tips 데이터에서 조건에 해당하는 데이터만 출력하기
    tips2 = tips.loc[(tips['day'] == option) | (tips['tip'] >= tip), :]

    # 위에서 출력한 tips 데이터에 따라 그래프로 뽑기
    import plotly.express as px
    fig = px.scatter(data_frame = tips2, x = "total_bill", y = "tip" )
    st.plotly_chart(fig)


    if show_plot:

        fig, ax = plt.subplots()
        ax.set_title("Hello World!")
        ax.boxplot(data=tips, x = 'total_bill')
        st.pyplot(fig) #plt.show()

if __name__ == "__main__":
    main()        