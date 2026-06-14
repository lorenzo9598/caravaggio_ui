(function () {
  'use strict';

  const navToggle = document.querySelector('.nav-toggle');
  const navLinks = document.querySelector('.nav-links');
  const navActions = document.querySelector('.nav-actions');

  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      const expanded = navToggle.getAttribute('aria-expanded') === 'true';
      navToggle.setAttribute('aria-expanded', String(!expanded));
      navLinks.classList.toggle('open');
      navActions?.classList.toggle('open');
    });

    navLinks.querySelectorAll('a[href^="#"]').forEach((link) => {
      link.addEventListener('click', () => {
        navToggle.setAttribute('aria-expanded', 'false');
        navLinks.classList.remove('open');
        navActions?.classList.remove('open');
      });
    });
  }

  document.querySelectorAll('[data-copy]').forEach((button) => {
    button.addEventListener('click', async () => {
      const selector = button.getAttribute('data-copy');
      const target = document.querySelector(selector);
      if (!target) return;

      const text = target.textContent.trim();

      try {
        await navigator.clipboard.writeText(text);
        const label = button.querySelector('span');
        const original = label?.textContent ?? 'Copy';
        if (label) label.textContent = 'Copied!';
        setTimeout(() => {
          if (label) label.textContent = original;
        }, 1800);
      } catch {
        const range = document.createRange();
        range.selectNodeContents(target);
        const selection = window.getSelection();
        selection?.removeAllRanges();
        selection?.addRange(range);
      }
    });
  });

  const revealElements = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: '0px 0px -40px 0px' }
    );

    revealElements.forEach((el) => observer.observe(el));
  } else {
    revealElements.forEach((el) => el.classList.add('visible'));
  }

  const header = document.querySelector('.site-header');
  let lastScroll = 0;

  window.addEventListener(
    'scroll',
    () => {
      const current = window.scrollY;
      if (!header) return;

      if (current > 24) {
        header.style.boxShadow = '0 4px 24px rgba(63, 20, 90, 0.08)';
      } else {
        header.style.boxShadow = 'none';
      }

      lastScroll = current;
    },
    { passive: true }
  );
})();
